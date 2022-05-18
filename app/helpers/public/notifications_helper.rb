module Public::NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @review = nil
    @visiter_review = notification.review_id
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href: customer_path(@visiter), class: "font-weight-bold text-dark") + "があなたをフォローしました"
      when "favorite" then
        tag.a(notification.visiter.name, href: customer_path(@visiter), class: "font-weight-bold text-dark") + "が" + tag.a("あなたの投稿", href: recipe_path(notification.recipe_id), class: "font-weight-bold text-dark") + "にいいねしました"
      when "review" then
        @review = Review.find_by(id: @visiter_review)&.comment
        tag.a(@visiter.name, href: customer_path(@visiter), class: "font-weight-bold text-dark") + "が" + tag.a("あなたの投稿", href: recipe_path(notification.recipe_id), class: "font-weight-bold text-dark") + "にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end
end
