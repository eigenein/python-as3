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
   
   public class ClanBlackListPopUpMediator extends PopupMediator
   {
       
      
      private var _blackList:Array;
      
      private var _signal_blackListUpdate:Signal;
      
      public function ClanBlackListPopUpMediator(param1:Player)
      {
         _signal_blackListUpdate = new Signal();
         super(param1);
         param1.clan.clan.blackList.signal_blackListUpdate.add(handler_blackListUpdate);
         var _loc2_:CommandUserGetInfoByIds = GameModel.instance.actionManager.playerCommands.userGetInfoByIds(blackListUserIds);
         _loc2_.signal_complete.add(handler_commandUserGetInfoByIds);
      }
      
      public function get blackListUserIds() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = player.clan.clan.blackList.list;
         for(var _loc2_ in player.clan.clan.blackList.list)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
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
         _popup = new ClanBlackListPopUp(this);
         return _popup;
      }
      
      public function blackListDrop() : void
      {
         GameModel.instance.actionManager.clan.clanRemoveFromBlackList(blackListUserIds);
         close();
      }
      
      public function blackListRemove(param1:String) : void
      {
         GameModel.instance.actionManager.clan.clanRemoveFromBlackList([param1]);
      }
      
      public function showUserInfo(param1:ChatUserData) : void
      {
         var _loc2_:ChatUserInfoPopUpMediator = new ChatUserInfoPopUpMediator(player,param1);
         _loc2_.banAvaliable = false;
         _loc2_.open(Stash.click("clan_black_list_info",_popup.stashParams));
      }
      
      override protected function dispose() : void
      {
         player.clan.clan.blackList.signal_blackListUpdate.remove(handler_blackListUpdate);
         super.dispose();
      }
      
      private function handler_blackListUpdate() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < blackList.length)
         {
            if(!player.clan.clan.blackList.list.hasOwnProperty((blackList[_loc1_] as ChatUserData).id))
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
