package game.view.popup.blasklist
{
   import game.command.rpc.player.CommandUserGetInfoByIds;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.chat.userinfo.ChatUserInfoPopUpMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.chat.ChatUserData;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class BlackListPopUpClipMediator extends PopupMediator
   {
       
      
      private var _blackList:Array;
      
      private var _signal_blackListUpdate:Signal;
      
      public function BlackListPopUpClipMediator(param1:Player)
      {
         _signal_blackListUpdate = new Signal();
         super(param1);
         param1.chat.signal_blackListUpdate.add(handler_blackListUpdate);
         var _loc2_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = param1.chat.blackList;
         for(var _loc3_ in param1.chat.blackList)
         {
            _loc2_.push(_loc3_);
         }
         var _loc4_:CommandUserGetInfoByIds = GameModel.instance.actionManager.playerCommands.userGetInfoByIds(_loc2_);
         _loc4_.signal_complete.add(handler_commandUserGetInfoByIds);
      }
      
      public function get blackList() : Array
      {
         return _blackList;
      }
      
      public function set blackList(param1:Array) : void
      {
         _blackList = param1;
      }
      
      public function get signal_blackListUpdate() : Signal
      {
         return _signal_blackListUpdate;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BlackListPopUp(this);
         return _popup;
      }
      
      public function blackListDrop() : void
      {
         GameModel.instance.actionManager.chat.chatBlackListDrop(player);
         close();
      }
      
      public function blackListRemove(param1:*) : void
      {
         GameModel.instance.actionManager.chat.chatBlackListRemove(player,param1);
      }
      
      public function showUserInfo(param1:ChatUserData) : void
      {
         var _loc2_:ChatUserInfoPopUpMediator = new ChatUserInfoPopUpMediator(player,param1);
         _loc2_.banAvaliable = false;
         _loc2_.open(Stash.click("black_list_info",_popup.stashParams));
      }
      
      override protected function dispose() : void
      {
         player.chat.signal_blackListUpdate.remove(handler_blackListUpdate);
         super.dispose();
      }
      
      private function handler_blackListUpdate() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < blackList.length)
         {
            if(!player.chat.blackList[(blackList[_loc1_] as ChatUserData).id])
            {
               blackList.splice(_loc1_,1);
               _loc1_--;
            }
            _loc1_++;
         }
         signal_blackListUpdate.dispatch();
      }
      
      private function handler_commandUserGetInfoByIds(param1:CommandUserGetInfoByIds) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         if(param1.result.body)
         {
            _loc3_ = param1.result.body.users;
            blackList = [];
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               blackList.push(new ChatUserData(_loc3_[_loc2_]));
               _loc2_++;
            }
            signal_blackListUpdate.dispatch();
         }
      }
   }
}
