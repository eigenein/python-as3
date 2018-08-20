package game.mediator.gui.popup.mail
{
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.command.rpc.mail.CommandMailFarm;
   import game.command.rpc.mail.CommandMailGet;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   import game.model.user.mail.PlayerMailEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.mail.PlayerMailEntryPopup;
   import game.view.popup.mail.PlayerMailPopup;
   import game.view.popup.reward.multi.MultiRewardGroupedPopup;
   import idv.cjcat.signals.Signal;
   
   public class PlayerMailPopupMeditator extends PopupMediator
   {
       
      
      private var _signal_mailDeleted:Signal;
      
      private var _data:ListCollection;
      
      public function PlayerMailPopupMeditator(param1:Player)
      {
         _signal_mailDeleted = new Signal(PlayerMailEntryValueObject);
         super(param1);
         _data = new ListCollection();
         if(param1.mail.updateRequired)
         {
            rpcUpdateMail();
         }
         else
         {
            updateMail();
         }
         param1.mail.signal_mailUpdated.add(handler_mailUpdated);
      }
      
      override protected function dispose() : void
      {
         player.mail.signal_mailUpdated.remove(handler_mailUpdated);
      }
      
      public function get signal_mailDeleted() : Signal
      {
         return _signal_mailDeleted;
      }
      
      public function get data() : ListCollection
      {
         return _data;
      }
      
      public function get canMultiFarm() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = data.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = data.getItemAt(_loc2_) as PlayerMailEntryValueObject;
            if(_loc3_.canMassFarm)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new PlayerMailPopup(this);
         return _popup;
      }
      
      public function action_mailSelect(param1:PlayerMailEntryValueObject) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.isImportant)
         {
            _loc3_ = new PlayerMailImportantPopupMediator(player);
            _loc3_.open(Stash.click("mail_important",_popup.stashParams));
         }
         else if(param1.text)
         {
            _loc2_ = new PlayerMailEntryPopup(param1);
            PopUpManager.addPopUp(_loc2_);
            _loc2_.signal_farm.add(onMailReadPopupAction_farm);
         }
         else
         {
            GameModel.instance.actionManager.mail.mailFarm(param1.mail);
         }
      }
      
      public function action_mailSelectAll() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Vector.<PlayerMailEntry> = new Vector.<PlayerMailEntry>();
         var _loc1_:int = _data.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = _data.getItemAt(_loc3_) as PlayerMailEntryValueObject;
            if(_loc4_.canMassFarm)
            {
               _loc2_.push(_loc4_.mail);
            }
            _loc3_++;
         }
         var _loc5_:CommandMailFarm = GameModel.instance.actionManager.mail.mailFarmMulti(_loc2_);
         _loc5_.onClientExecute(handler_mailMultiFarm);
      }
      
      private function onMailReadPopupAction_farm(param1:PlayerMailEntryValueObject) : void
      {
         if(param1.farmIsAvailable)
         {
            GameModel.instance.actionManager.mail.mailFarm(param1.mail);
         }
         else
         {
            player.mail.farmLetters(new <PlayerMailEntry>[param1.mail]);
         }
      }
      
      protected function updateMail() : void
      {
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc4_:Vector.<PlayerMailEntryValueObject> = new Vector.<PlayerMailEntryValueObject>();
         var _loc2_:Vector.<PlayerMailEntry> = player.mail.getList();
         var _loc3_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[_loc5_] = new PlayerMailEntryValueObject(_loc2_[_loc5_]);
            _loc4_[_loc5_].title = PlayerMailEntryTranslation.translateTitle(_loc2_[_loc5_]);
            _loc4_[_loc5_].text = PlayerMailEntryTranslation.translateText(_loc2_[_loc5_]);
            _loc4_[_loc5_].signal_deleted.add(onMailEntryDeleted);
            if(_loc2_[_loc5_].user)
            {
               _loc1_ = player.friends.getByAccountId(_loc2_[_loc5_].user.accountId);
               _loc4_[_loc5_].playerFriend = _loc1_;
            }
            _loc5_++;
         }
         if(_data)
         {
            _data.data = _loc4_;
         }
         else
         {
            _data = new ListCollection(_loc4_);
         }
      }
      
      private function rpcUpdateMail() : void
      {
         var _loc1_:CommandMailGet = GameModel.instance.actionManager.mail.mailGet();
         _loc1_.onClientExecute(handler_mailGet);
      }
      
      private function onMailEntryDeleted(param1:PlayerMailEntryValueObject) : void
      {
         _data.removeItem(param1);
         _signal_mailDeleted.dispatch(param1);
      }
      
      private function handler_mailMultiFarm(param1:CommandMailFarm) : void
      {
         PopUpManager.addPopUp(new MultiRewardGroupedPopup(param1.rewardList));
      }
      
      private function handler_mailUpdated() : void
      {
         updateMail();
      }
      
      private function handler_mailGet(param1:CommandMailGet) : void
      {
      }
   }
}
