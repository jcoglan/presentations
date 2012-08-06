!SLIDE title
# Flexibility vs convenience
## Songkick’s web services

!SLIDE
# Convenient

    @@@ruby
    File.read('path/to/file.txt')

!SLIDE
# Flexible

    @@@java
    FileInputStream fstream = 
        new FileInputStream("path/to/file.txt");
        
    DataInputStream in = 
        new DataInputStream(fstream);
        
    BufferedReader br = 
        new BufferedReader(new InputStreamReader(in));

!SLIDE
# Convenient

    @@@ruby
    concert = Concert.find(params[:id])

!SLIDE
# Flexible?

    @@@ruby
    http_client = HTTPClient.new('http://concerts-service')
    concerts_client = ConcertsClient.new(http_client)
    concert = concerts_client.find(params[:id])

!SLIDE title
# We use flexible building blocks and convenient wrappers

!SLIDE

    @@@ruby
    class Services::ConcertsClient
      def initialize(http_client)
        @http = http_client
      end
      
      def find(id)
        data = @http.get("/concerts/#{id}").json_data
        Models::Concert.new(data)
      end
    end

!SLIDE

    @@@ruby
    class Models::Concert
      def initialize(data)
        @json_data = data
      end
      
      def name
        @json_data['name']
      end
      
      def headliners
        @json_data['performances'].
            select { |p| p['billing'] == 'headline' }.
            map { |p| Models::Artist.new(p['artist']) }
      end
    end

!SLIDE

    @@@ruby
    module Services
      def self.concerts
        @concerts ||= begin
                        uri  = 'http://concerts-service'
                        http = HTTPClient.new(uri)
                        ConcertsClient.new(http)
                      end
      end
    end

!SLIDE

    @@@ruby
    concert = Services.concerts.find(params[:id])