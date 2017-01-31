module Api::Controllers::Speakers
  class List
    include Api::Action
    accept :json

    expose :speakers

    def call(params)
      @speakers = SpeakerRepository.new.all
    end
  end
end
