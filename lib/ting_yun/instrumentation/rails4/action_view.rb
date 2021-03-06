# encoding: utf-8

require 'ting_yun/instrumentation/support/action_view_subscriber'

TingYun::Support::LibraryDetection.defer do
  @name = :rails4_view

  depends_on do
    !::TingYun::Agent.config[:disable_action_view]
  end

  depends_on do
    defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i == 4
  end

  depends_on do
    !TingYun::Agent.config[:disable_view_instrumentation] &&
        !TingYun::Instrumentation::Rails::ActionViewSubscriber.subscribed?
  end

  executes do
    TingYun::Agent.logger.info 'Installing Rails 4 view instrumentation'
  end

  executes do
    TingYun::Instrumentation::Rails::ActionViewSubscriber.subscribe(/render_.+\.action_view$/)
  end
end
#
