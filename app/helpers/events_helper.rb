module EventsHelper

  def detail_for_event(event)
    creator = event.creator.try(:display_name) || t('no_user')
    time = event.created_at? ? time_ago_in_words(event.created_at) : t('no_time')
    t('events.detail', creator: creator, time: time)
  end

end