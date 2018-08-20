package game.model.user.ny
{
   import game.command.realtime.SocketClientEvent;
   import game.command.rpc.ny.NYFireworksLaunchPersonVO;
   import game.model.GameModel;
   import game.view.gui.homescreen.HomeScreenSceneNYFireworks;
   import idv.cjcat.signals.Signal;
   
   public class NewYearData
   {
       
      
      private var _dayHeroId:int;
      
      private var _eventHeroId:int;
      
      private var _giftsToOpen:int;
      
      private var _treeLevel:int;
      
      private var _treeExpPercent:Number;
      
      public var signal_treeExpChange:Signal;
      
      public var signal_giftsToOpenChange:Signal;
      
      public function NewYearData()
      {
         signal_treeExpChange = new Signal();
         signal_giftsToOpenChange = new Signal();
         super();
      }
      
      public function get dayHeroId() : int
      {
         return _dayHeroId;
      }
      
      public function set dayHeroId(param1:int) : void
      {
         _dayHeroId = param1;
      }
      
      public function get eventHeroId() : int
      {
         return _eventHeroId;
      }
      
      public function set eventHeroId(param1:int) : void
      {
         _eventHeroId = param1;
      }
      
      public function get giftsToOpen() : int
      {
         return _giftsToOpen;
      }
      
      public function set giftsToOpen(param1:int) : void
      {
         if(_giftsToOpen == param1)
         {
            return;
         }
         _giftsToOpen = param1;
         signal_giftsToOpenChange.dispatch();
      }
      
      public function get treeLevel() : int
      {
         return _treeLevel;
      }
      
      public function set treeLevel(param1:int) : void
      {
         _treeLevel = param1;
      }
      
      public function get treeExpPercent() : Number
      {
         return _treeExpPercent;
      }
      
      public function set treeExpPercent(param1:Number) : void
      {
         if(_treeExpPercent == param1)
         {
            return;
         }
         _treeExpPercent = param1;
         signal_treeExpChange.dispatch();
      }
      
      public function init(param1:Object) : void
      {
         GameModel.instance.actionManager.messageClient.subscribe("ny2018TreeLevelUp",onAsyncNYTreeLevelUp);
         GameModel.instance.actionManager.messageClient.subscribe("nyGiftSend",onAsyncNYGiftSend);
         GameModel.instance.actionManager.messageClient.subscribe("fireworks",onAsyncNYFireworks);
         update(param1);
      }
      
      public function update(param1:Object) : void
      {
         dayHeroId = param1.dayHero;
         eventHeroId = param1.eventHero;
         giftsToOpen = param1.giftsToOpen;
         treeLevel = param1.treeLevel;
         treeExpPercent = param1.treeExpPercent;
      }
      
      private function onAsyncNYGiftSend(param1:SocketClientEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = param1.data.body;
         if(_loc3_)
         {
            _loc2_ = _loc3_.userId;
            giftsToOpen = giftsToOpen + _loc3_.amount;
         }
      }
      
      private function onAsyncNYTreeLevelUp(param1:SocketClientEvent) : void
      {
         var _loc2_:Object = param1.data.body;
         if(_loc2_)
         {
            treeLevel = _loc2_.treeLevel;
            treeExpPercent = _loc2_.treeExpPercent;
         }
      }
      
      private function onAsyncNYFireworks(param1:SocketClientEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = param1.data.body;
         if(_loc3_ && _loc3_.serverId == GameModel.instance.player.serverId)
         {
            if(HomeScreenSceneNYFireworks.instance)
            {
               _loc2_ = new NYFireworksLaunchPersonVO(_loc3_);
               HomeScreenSceneNYFireworks.instance.action_launch(_loc2_,_loc3_.userId == GameModel.instance.player.id);
            }
         }
      }
   }
}
