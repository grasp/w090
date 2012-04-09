#module Rforum
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      # not logged in
      cannot :manage, :all
      basic_read_only

    elsif user.has_role?(:admin)
      # admin
      can :manage, :all
    elsif user.has_role?(:member)
      # Topic
      can :create, Rforum::Topic
      can :update, Rforum::Topic do |topic|
        (topic.user_id == user.id)
      end
      can :destroy, Rforum::Topic do |topic|
         (topic.user_id == user.id)
      end

      # Reply
      can :create, Rforum::Reply
      can :update, Rforum::Reply do |reply|
        reply.user_id == user.id
      end
      can :destroy, Rforum::Reply do |reply|
        reply.user_id == user.id
      end

      # Note
      can :create, Rforum::Note
      can :update, Rforum::Note do |note|
        note.user_id == user.id
      end
      can :destroy, Rforum::Note do |note|
        note.user_id == user.id
      end
      can :read, Rforum::Note do |note|
        note.user_id == user.id
      end
      can :read  , Rforum::Note do |note|
        note.publish == true
      end

      # Wiki
      if user.has_role?(:wiki_editor)
        can :create, Rforum::Page
        can :edit, Rforum::Page do |page|
          page.locked == false
        end
        can :update, Rforum::Page do |page|
          page.locked == false
        end
      end


      # Photo
      can :tiny_new, Rforum::Photo
      can :create, Rforum::Photo
      can :update, Rforum::Photo do |photo|
        photo.user_id == photo.id
      end
      can :destroy, Rforum::Photo do |photo|
        photo.user_id == photo.id
      end

      # Comment
      can :create, Rforum::Comment
      can :update, Rforum::Comment do |comment|
        comment.user_id == comment.id
      end
      can :destroy, Rforum::Comment do |comment|
        comment.user_id == comment.id
      end

      # Site
      can :create, Rforum::Site

      basic_read_only
    else
      # banned or unknown situation
      cannot :manage, :all
      basic_read_only
    end


  end

  protected
    def basic_read_only
      can :read,Rforum::Topic
      can :feed,Rforum::Topic
      can :node,Rforum::Topic

      can :read, Rforum::Reply

      can :read,  Rforum::Page
      can :recent, Rforum::Page

      can :read, Rforum::Photo
      can :read, Rforum::Site
      can :read, Rforum::Section
      can :read, Rforum::Node
      can :read, Rforum::Comment
    end
end
#end
