package engine.context.platform.social.socialQuest
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import game.global.GlobalEventController;
   import idv.cjcat.signals.Signal;
   
   public class SocialQuestHelper
   {
      
      protected static var _instance:SocialQuestHelper;
       
      
      public var GROUP_URL:String;
      
      public var GROUP_ID:String;
      
      protected var _canCheckGroupStatus:Boolean;
      
      protected var _canCheck_bookmarkStatus:Boolean;
      
      protected var _signal_action_groupJoin:Signal;
      
      protected var _signal_action_bookmark:Signal;
      
      protected var _actionComplete_groupJoin:Boolean;
      
      protected var _actionComplete_bookmark:Boolean;
      
      public function SocialQuestHelper(param1:Object)
      {
         _signal_action_groupJoin = new Signal();
         _signal_action_bookmark = new Signal();
         super();
         _instance = this;
         GROUP_URL = param1.group_url;
         GROUP_ID = param1.group_id;
      }
      
      public static function get instance() : SocialQuestHelper
      {
         return _instance;
      }
      
      public function get canCheck_groupStatus() : Boolean
      {
         return _canCheckGroupStatus;
      }
      
      public function get canCheck_bookmarkStatus() : Boolean
      {
         return _canCheck_bookmarkStatus;
      }
      
      public function get signal_action_groupJoin() : Signal
      {
         return _signal_action_groupJoin;
      }
      
      public function get signal_action_bookmark() : Signal
      {
         return _signal_action_bookmark;
      }
      
      public function get actionComplete_groupJoin() : Boolean
      {
         return _actionComplete_groupJoin;
      }
      
      public function get actionComplete_bookmark() : Boolean
      {
         return _actionComplete_bookmark;
      }
      
      public function action_groupJoin() : void
      {
         GlobalEventController.signal_redirect.dispatch();
      }
      
      public function actionHelp_navigateToGroupURL() : void
      {
      }
      
      public function action_bookmark() : void
      {
      }
   }
}
