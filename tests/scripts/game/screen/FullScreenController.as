package game.screen
{
   import com.progrestar.common.social.SocialAdapter;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import game.global.GlobalEventController;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.stat.Stash;
   import starling.core.Starling;
   
   public class FullScreenController
   {
      
      private static var _instance:FullScreenController;
       
      
      public function FullScreenController()
      {
         super();
      }
      
      public static function get instance() : FullScreenController
      {
         if(!_instance)
         {
            _instance = new FullScreenController();
         }
         return _instance;
      }
      
      public function fullScreenOn() : void
      {
         Starling.current.nativeStage.displayState = "fullScreenInteractive";
         Starling.current.nativeStage.addEventListener("fullScreen",handler_fullScreenStateChange);
         SocialAdapter.instance.addEventListener("openSocialBox",handler_socialBoxOpen);
         GlobalEventController.signal_redirect.add(handler_redirect);
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "global";
         Stash.click("full_screen_on",_loc1_);
      }
      
      public function fullScreenOff() : void
      {
         if(Starling.current.nativeStage.hasEventListener("fullScreen"))
         {
            Starling.current.nativeStage.removeEventListener("fullScreen",handler_fullScreenStateChange);
         }
         if(SocialAdapter.instance.hasEventListener("openSocialBox"))
         {
            SocialAdapter.instance.removeEventListener("openSocialBox",handler_socialBoxOpen);
         }
         GlobalEventController.signal_redirect.remove(handler_redirect);
         Starling.current.nativeStage.displayState = "normal";
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "global";
         Stash.click("full_screen_off",_loc1_);
      }
      
      private function handler_redirect() : void
      {
         if(Starling.current.nativeStage.displayState != "normal")
         {
            fullScreenOff();
         }
      }
      
      private function handler_fullScreenStateChange(param1:FullScreenEvent) : void
      {
         if(!param1.fullScreen)
         {
            fullScreenOff();
         }
      }
      
      protected function handler_socialBoxOpen(param1:Event) : void
      {
         if(Starling.current.nativeStage.displayState != "normal")
         {
            fullScreenOff();
         }
      }
   }
}
