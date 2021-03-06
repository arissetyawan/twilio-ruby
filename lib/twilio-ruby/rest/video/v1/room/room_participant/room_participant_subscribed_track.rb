##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /

module Twilio
  module REST
    class Video < Domain
      class V1 < Version
        class RoomContext < InstanceContext
          class ParticipantContext < InstanceContext
            class SubscribedTrackList < ListResource
              ##
              # Initialize the SubscribedTrackList
              # @param [Version] version Version that contains the resource
              # @param [String] room_sid The room_sid
              # @param [String] subscriber_sid The subscriber_sid
              # @return [SubscribedTrackList] SubscribedTrackList
              def initialize(version, room_sid: nil, subscriber_sid: nil)
                super(version)

                # Path Solution
                @solution = {room_sid: room_sid, subscriber_sid: subscriber_sid}
                @uri = "/Rooms/#{@solution[:room_sid]}/Participants/#{@solution[:subscriber_sid]}/SubscribedTracks"
              end

              ##
              # Lists SubscribedTrackInstance records from the API as a list.
              # Unlike stream(), this operation is eager and will load `limit` records into
              # memory before returning.
              # @param [Time] date_created_after The date_created_after
              # @param [Time] date_created_before The date_created_before
              # @param [String] track The track
              # @param [String] publisher The publisher
              # @param [subscribed_track.Kind] kind The kind
              # @param [Integer] limit Upper limit for the number of records to return. stream()
              #    guarantees to never return more than limit.  Default is no limit
              # @param [Integer] page_size Number of records to fetch per request, when
              #    not set will use the default value of 50 records.  If no page_size is defined
              #    but a limit is defined, stream() will attempt to read the limit with the most
              #    efficient page size, i.e. min(limit, 1000)
              # @return [Array] Array of up to limit results
              def list(date_created_after: :unset, date_created_before: :unset, track: :unset, publisher: :unset, kind: :unset, limit: nil, page_size: nil)
                self.stream(
                    date_created_after: date_created_after,
                    date_created_before: date_created_before,
                    track: track,
                    publisher: publisher,
                    kind: kind,
                    limit: limit,
                    page_size: page_size
                ).entries
              end

              ##
              # Streams SubscribedTrackInstance records from the API as an Enumerable.
              # This operation lazily loads records as efficiently as possible until the limit
              # is reached.
              # @param [Time] date_created_after The date_created_after
              # @param [Time] date_created_before The date_created_before
              # @param [String] track The track
              # @param [String] publisher The publisher
              # @param [subscribed_track.Kind] kind The kind
              # @param [Integer] limit Upper limit for the number of records to return. stream()
              #    guarantees to never return more than limit. Default is no limit.
              # @param [Integer] page_size Number of records to fetch per request, when
              #    not set will use the default value of 50 records. If no page_size is defined
              #    but a limit is defined, stream() will attempt to read the limit with the most
              #    efficient page size, i.e. min(limit, 1000)
              # @return [Enumerable] Enumerable that will yield up to limit results
              def stream(date_created_after: :unset, date_created_before: :unset, track: :unset, publisher: :unset, kind: :unset, limit: nil, page_size: nil)
                limits = @version.read_limits(limit, page_size)

                page = self.page(
                    date_created_after: date_created_after,
                    date_created_before: date_created_before,
                    track: track,
                    publisher: publisher,
                    kind: kind,
                    page_size: limits[:page_size],
                )

                @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
              end

              ##
              # When passed a block, yields SubscribedTrackInstance records from the API.
              # This operation lazily loads records as efficiently as possible until the limit
              # is reached.
              def each
                limits = @version.read_limits

                page = self.page(page_size: limits[:page_size], )

                @version.stream(page,
                                limit: limits[:limit],
                                page_limit: limits[:page_limit]).each {|x| yield x}
              end

              ##
              # Retrieve a single page of SubscribedTrackInstance records from the API.
              # Request is executed immediately.
              # @param [Time] date_created_after The date_created_after
              # @param [Time] date_created_before The date_created_before
              # @param [String] track The track
              # @param [String] publisher The publisher
              # @param [subscribed_track.Kind] kind The kind
              # @param [String] page_token PageToken provided by the API
              # @param [Integer] page_number Page Number, this value is simply for client state
              # @param [Integer] page_size Number of records to return, defaults to 50
              # @return [Page] Page of SubscribedTrackInstance
              def page(date_created_after: :unset, date_created_before: :unset, track: :unset, publisher: :unset, kind: :unset, page_token: :unset, page_number: :unset, page_size: :unset)
                params = Twilio::Values.of({
                    'DateCreatedAfter' => Twilio.serialize_iso8601_datetime(date_created_after),
                    'DateCreatedBefore' => Twilio.serialize_iso8601_datetime(date_created_before),
                    'Track' => track,
                    'Publisher' => publisher,
                    'Kind' => kind,
                    'PageToken' => page_token,
                    'Page' => page_number,
                    'PageSize' => page_size,
                })
                response = @version.page(
                    'GET',
                    @uri,
                    params
                )
                SubscribedTrackPage.new(@version, response, @solution)
              end

              ##
              # Retrieve a single page of SubscribedTrackInstance records from the API.
              # Request is executed immediately.
              # @param [String] target_url API-generated URL for the requested results page
              # @return [Page] Page of SubscribedTrackInstance
              def get_page(target_url)
                response = @version.domain.request(
                    'GET',
                    target_url
                )
                SubscribedTrackPage.new(@version, response, @solution)
              end

              ##
              # Update the SubscribedTrackInstance
              # @param [String] track The track
              # @param [String] publisher The publisher
              # @param [subscribed_track.Kind] kind The kind
              # @param [subscribed_track.Status] status The status
              # @return [SubscribedTrackInstance] Updated SubscribedTrackInstance
              def update(track: :unset, publisher: :unset, kind: :unset, status: :unset)
                data = Twilio::Values.of({
                    'Track' => track,
                    'Publisher' => publisher,
                    'Kind' => kind,
                    'Status' => status,
                })

                payload = @version.update(
                    'POST',
                    @uri,
                    data: data,
                )

                SubscribedTrackInstance.new(
                    @version,
                    payload,
                    room_sid: @solution[:room_sid],
                    subscriber_sid: @solution[:subscriber_sid],
                )
              end

              ##
              # Provide a user friendly representation
              def to_s
                '#<Twilio.Video.V1.SubscribedTrackList>'
              end
            end

            class SubscribedTrackPage < Page
              ##
              # Initialize the SubscribedTrackPage
              # @param [Version] version Version that contains the resource
              # @param [Response] response Response from the API
              # @param [Hash] solution Path solution for the resource
              # @return [SubscribedTrackPage] SubscribedTrackPage
              def initialize(version, response, solution)
                super(version, response)

                # Path Solution
                @solution = solution
              end

              ##
              # Build an instance of SubscribedTrackInstance
              # @param [Hash] payload Payload response from the API
              # @return [SubscribedTrackInstance] SubscribedTrackInstance
              def get_instance(payload)
                SubscribedTrackInstance.new(
                    @version,
                    payload,
                    room_sid: @solution[:room_sid],
                    subscriber_sid: @solution[:subscriber_sid],
                )
              end

              ##
              # Provide a user friendly representation
              def to_s
                '<Twilio.Video.V1.SubscribedTrackPage>'
              end
            end

            class SubscribedTrackInstance < InstanceResource
              ##
              # Initialize the SubscribedTrackInstance
              # @param [Version] version Version that contains the resource
              # @param [Hash] payload payload that contains response from Twilio
              # @param [String] room_sid The room_sid
              # @param [String] subscriber_sid The subscriber_sid
              # @return [SubscribedTrackInstance] SubscribedTrackInstance
              def initialize(version, payload, room_sid: nil, subscriber_sid: nil)
                super(version)

                # Marshaled Properties
                @properties = {
                    'sid' => payload['sid'],
                    'room_sid' => payload['room_sid'],
                    'name' => payload['name'],
                    'publisher_sid' => payload['publisher_sid'],
                    'subscriber_sid' => payload['subscriber_sid'],
                    'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                    'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                    'enabled' => payload['enabled'],
                    'kind' => payload['kind'],
                }
              end

              ##
              # @return [String] The sid
              def sid
                @properties['sid']
              end

              ##
              # @return [String] The room_sid
              def room_sid
                @properties['room_sid']
              end

              ##
              # @return [String] The name
              def name
                @properties['name']
              end

              ##
              # @return [String] The publisher_sid
              def publisher_sid
                @properties['publisher_sid']
              end

              ##
              # @return [String] The subscriber_sid
              def subscriber_sid
                @properties['subscriber_sid']
              end

              ##
              # @return [Time] The date_created
              def date_created
                @properties['date_created']
              end

              ##
              # @return [Time] The date_updated
              def date_updated
                @properties['date_updated']
              end

              ##
              # @return [Boolean] The enabled
              def enabled
                @properties['enabled']
              end

              ##
              # @return [subscribed_track.Kind] The kind
              def kind
                @properties['kind']
              end

              ##
              # Provide a user friendly representation
              def to_s
                "<Twilio.Video.V1.SubscribedTrackInstance>"
              end

              ##
              # Provide a detailed, user friendly representation
              def inspect
                "<Twilio.Video.V1.SubscribedTrackInstance>"
              end
            end
          end
        end
      end
    end
  end
end