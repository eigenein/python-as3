package game.model.user.sharedobject
{
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   import game.command.timer.GameTimer;
   
   public class PlayerSharedObjectStorage
   {
      
      private static const so_name:String = "game.mediator.gui.popup.AutoPopupMediator";
      
      private static const DAY:int = 86400;
      
      public static const var_socialQuest:String = "game.mediator.gui.popup.AutoPopupMediator.socialQuest";
      
      public static const var_communityPromo:String = "game.mediator.gui.popup.AutoPopupMediator.communityPromo";
      
      public static const var_raidPromo:String = "game.mediator.gui.popup.AutoPopupMediator.communityPromo";
      
      public static const var_mergeBonus:String = "game.view.popup.merge.MergeInfoPopUpMediator.mergeBonus";
      
      public static const var_specialOfferSideBarIconControllerMethod:String = "game.view.gui.overlay.offer.SpecialOfferSideBarIconController.method";
      
      public static const var_refreshMeta:String = "refreshMeta";
       
      
      private var so:SharedObject;
      
      private var timeouts:Dictionary;
      
      public function PlayerSharedObjectStorage()
      {
         timeouts = new Dictionary();
         super();
         timeouts = new Dictionary();
         timeouts["game.mediator.gui.popup.AutoPopupMediator.socialQuest"] = 86400;
         timeouts["game.mediator.gui.popup.AutoPopupMediator.communityPromo"] = 86400;
         timeouts["game.mediator.gui.popup.AutoPopupMediator.communityPromo"] = 86400;
         timeouts["game.view.popup.merge.MergeInfoPopUpMediator.mergeBonus"] = 86400;
         timeouts["game.view.gui.overlay.offer.SpecialOfferSideBarIconController.method"] = NaN;
      }
      
      public function initialize() : void
      {
         try
         {
            so = SharedObject.getLocal("game.mediator.gui.popup.AutoPopupMediator");
            return;
         }
         catch(error:Error)
         {
            return;
         }
      }
      
      public function debug_clearAll() : void
      {
         if(so)
         {
            so.clear();
         }
      }
      
      public function setTimeout(param1:String, param2:int) : void
      {
         timeouts[param1] = param2;
      }
      
      public function readTimeout(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         if(so && so.data)
         {
            _loc2_ = so.data[param1];
            _loc2_ = GameTimer.instance.currentServerTime - _loc2_;
            return _loc2_ > timeouts[param1];
         }
         return true;
      }
      
      public function writeTimeout(param1:String) : void
      {
         try
         {
            if(so && so.data)
            {
               so.data[param1] = GameTimer.instance.currentServerTime;
               so.flush();
            }
            return;
         }
         catch(error:Error)
         {
            return;
         }
      }
      
      public function get refreshMeta() : RefreshMetadata
      {
         try
         {
            if(so && so.data)
            {
               var _loc2_:* = RefreshMetadata.fromObject(so.data["refreshMeta"]);
               return _loc2_;
            }
            var _loc3_:* = null;
            return _loc3_;
         }
         catch(e:*)
         {
         }
         return null;
      }
      
      public function set refreshMeta(param1:RefreshMetadata) : void
      {
         try
         {
            if(so && so.data)
            {
               so.data["refreshMeta"] = !!param1?param1.serialize():null;
               so.flush();
            }
            return;
         }
         catch(e:*)
         {
            return;
         }
      }
   }
}
