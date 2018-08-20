package game.stat
{
   import engine.context.platform.social.StoryPostResult;
   import engine.context.platform.social.U2URequestSendResult;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import game.command.rpc.stash.StashEventDescription;
   import game.command.rpc.stash.StoryPostStashEventParams;
   import game.command.rpc.stash.U2UStashEventParams;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.GameModel;
   
   public class Stash
   {
      
      public static const CLIENTSTAT_COMPLETE_LOADING:String = ".user.completeLoading";
      
      public static const CLIENTSTAT_FB_PROMO:String = ".client.fbPromotion";
      
      public static const CLIENTSTAT_CLIENT_OFFER:String = ".client.clientOffer";
      
      private static const SID:int = int(Math.random() * 2147483647);
       
      
      public function Stash()
      {
         super();
      }
      
      public static function click(param1:String, param2:PopupStashEventParams) : PopupStashEventParams
      {
         var _loc3_:PopupStashEventParams = new PopupStashEventParams();
         _loc3_.windowName = param2.windowName;
         _loc3_.buttonName = param1;
         _loc3_.actionType = ".client.button.click";
         var _loc4_:StashEventDescription = new StashEventDescription(".client.button.click",_loc3_);
         GameModel.instance.actionManager.stashEvent(_loc4_);
         return _loc3_;
      }
      
      public static function stat_u2u(param1:U2URequestSendResult, param2:String = "invitation") : void
      {
         var _loc3_:U2UStashEventParams = new U2UStashEventParams(param1,param2);
         var _loc4_:StashEventDescription = new StashEventDescription(".user.userNotification",_loc3_);
         GameModel.instance.actionManager.stashEvent(_loc4_);
      }
      
      public static function stat_storyPost(param1:StoryPostResult) : void
      {
         var _loc3_:* = null;
         _loc3_ = null;
         var _loc2_:StoryPostStashEventParams = new StoryPostStashEventParams(param1);
         if(!param1.code)
         {
            _loc3_ = new StashEventDescription(".client.opengraphSuccess",_loc2_);
         }
         else
         {
            _loc3_ = new StashEventDescription(".client.opengraphError",_loc2_);
         }
         GameModel.instance.actionManager.stashEvent(_loc3_);
      }
      
      public static function openTutorialMessage(param1:int) : void
      {
         var _loc2_:PopupStashEventParams = new PopupStashEventParams();
         _loc2_.windowName = "tutorialMessage:" + param1;
         _loc2_.actionType = ".client.window.open";
         var _loc3_:StashEventDescription = new StashEventDescription(".client.window.open",_loc2_);
         GameModel.instance.actionManager.stashEvent(_loc3_);
      }
      
      public static function closeTutorialMessage(param1:int) : void
      {
         var _loc2_:PopupStashEventParams = new PopupStashEventParams();
         _loc2_.windowName = "tutorialMessage:" + param1;
         _loc2_.actionType = ".client.window.close";
         var _loc3_:StashEventDescription = new StashEventDescription(".client.window.close",_loc2_);
         GameModel.instance.actionManager.stashEvent(_loc3_);
      }
      
      public static function sendClientStat(param1:String, param2:Object = null) : void
      {
         type = param1;
         data = param2;
         ioError = function(param1:Event):void
         {
         };
         if(!data)
         {
            var data:Object = {};
         }
         data["sid"] = SID;
         var url:String = GameModel.instance.context.rpcURL + "clientStat/?";
         var params:Array = [];
         params["networkIdent"] = GameModel.instance.context.platformFacade.network;
         params["applicationId"] = GameModel.instance.context.platformFacade.app_id;
         params["type"] = type;
         params["userId"] = GameModel.instance.context.platformFacade.userId;
         var _loc5_:int = 0;
         var _loc4_:* = data;
         for(key in data)
         {
            params["info[" + key + "]"] = data[key];
         }
         var prefix:String = "";
         var _loc7_:int = 0;
         var _loc6_:* = params;
         for(key in params)
         {
            url = url + prefix + key + "=" + params[key];
            prefix = "&";
         }
         var request:URLRequest = new URLRequest(url);
         request.method = "GET";
         request.data = params;
         var loader:URLLoader = new URLLoader();
         loader.addEventListener("ioError",ioError);
         loader.addEventListener("networkError",ioError);
         loader.addEventListener("diskError",ioError);
         loader.addEventListener("verifyError",ioError);
         loader.load(request);
      }
   }
}
