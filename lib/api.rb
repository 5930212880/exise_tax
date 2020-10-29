require 'rest-client'
require 'json'

petrol = RestClient.get 'http://petrol.excise-online.com/truck_trips.json',
    {
        'X-User-Email' => 'api_truck@petrol.excise-online.com',
        'X-User-Token' => 'ofFd99ZSDTpKzxTeV-Ts',
        :params => {
            'q[serial_number_eq]' => '64021000102326-01',
            'limit' => '1'
        }
    }

    parse = JSON.parse(petrol)
    parse.each do |v|
        puts "#{v['truck_to_s']}|#{v['truck_tail_to_s']}"
    end
    # puts parse['serial_number']