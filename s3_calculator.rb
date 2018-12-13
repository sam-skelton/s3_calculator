require 'aws-sdk-s3'
require 'json'

def fetch_results
  limit = ARGV[ 0 ].to_i
  region = ENV[ 'AWS_REGION' ]
  if ENV[ 'AWS_REGION' ] == 'us-east-1'
    location_constraint = ""
  else
    location_constraint = ENV[ 'AWS_REGION' ]
  end
  s3 = Aws::S3::Resource.new( region: region )
  s3_results = []
  s3.buckets.limit(limit).each do |bucket|
    if s3.client.get_bucket_location( bucket: bucket.name ).location_constraint == location_constraint #us-east-1 is an empty string in the ruby aws-sdk
      size = 0
      objects = bucket.objects
      obj_counter = 1
      objects.each do | object |
        puts "processing object #{ obj_counter } [#{ bucket.name }]"
        obj_counter += 1
        size += object.content_length
      end
      size_in_mb = to_mb( size )
      size_in_gb = to_gb( size )
      cost = get_cost( size_in_gb )
      s3_results.push( { name: bucket.name, size_in_mb: size_in_mb, cost: cost } )
    end
  end
  puts s3_results.to_json
end

def to_mb( size )
    size / (1024.0 * 1024.0) 
end

def to_gb ( size )
  size / (1024.0 * 1024.0 * 1024.0)
end

def get_cost( size_in_gb )
  size_in_gb * 0.021
end

fetch_results