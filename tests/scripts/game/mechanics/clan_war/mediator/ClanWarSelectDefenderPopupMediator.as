package game.mechanics.clan_war.mediator
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mechanics.clan_war.model.ClanWarPlanSlotValueObject;
   import game.mechanics.clan_war.popup.plan.selectdefender.ClanWarSelectDefenderPopup;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.PromptPopup;
   
   public class ClanWarSelectDefenderPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var slot:ClanWarPlanSlotValueObject;
      
      private var defenders:Vector.<ClanWarDefenderValueObject>;
      
      private var _defenderListData:ListCollection;
      
      private var _title:String;
      
      public function ClanWarSelectDefenderPopupMediator(param1:Player, param2:ClanWarPlanSlotValueObject, param3:Vector.<ClanWarDefenderValueObject>)
      {
         var _loc6_:int = 0;
         super(param1);
         this.slot = param2;
         this.defenders = param3;
         param3.sort(_sortDefenders);
         _defenderListData = new ListCollection();
         var _loc4_:int = param3.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(param1.clan.clanWarData.getUserIsWarrior(param3[_loc6_].user))
            {
               _defenderListData.addItem(param3[_loc6_]);
            }
            _loc6_++;
         }
         var _loc5_:ClanWarFortificationDescription = DataStorage.clanWar.getFortificationById(param2.desc.fortificationId);
         _title = Translate.translateArgs("UI_CLAN_WAR_DEFENDER_SELECT_POPUP_TF_HEADER",_loc5_.name,param2.slotNumber);
         param1.clan.clanWarData.signal_addWarrior.add(handler_addWarrior);
         param1.clan.clanWarData.signal_removeWarrior.add(handler_removeWarrior);
      }
      
      override protected function dispose() : void
      {
         player.clan.clanWarData.signal_addWarrior.remove(handler_addWarrior);
         player.clan.clanWarData.signal_removeWarrior.remove(handler_removeWarrior);
         super.dispose();
      }
      
      public function get defenderListData() : ListCollection
      {
         return _defenderListData;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function action_assignChampions() : void
      {
         var _loc1_:ClanWarAssignChampionsPopupMediator = new ClanWarAssignChampionsPopupMediator(player);
         _loc1_.open(Stash.click("warriors",_popup.stashParams));
      }
      
      public function action_select(param1:ClanWarDefenderValueObject) : void
      {
         executeCommandFillFortificationWithDefender(param1);
         close();
      }
      
      public function executeCommandFillFortificationWithDefender(param1:ClanWarDefenderValueObject) : void
      {
         player.clan.clanWarData.action_fillFortificationWithDefender(slot,param1);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarSelectDefenderPopup(this);
         return _popup;
      }
      
      private function _sortDefenders(param1:ClanWarDefenderValueObject, param2:ClanWarDefenderValueObject) : int
      {
         var _loc3_:int = !!param1.currentSlot?0:10000000;
         _loc3_ = _loc3_ + param1.teamPower;
         var _loc4_:int = !!param2.currentSlot?0:10000000;
         _loc4_ = _loc4_ + param2.teamPower;
         return _loc4_ - _loc3_;
      }
      
      private function handler_removeWarrior(param1:String) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < defenders.length)
         {
            if(defenders[_loc2_].userId == param1)
            {
               _defenderListData.removeItem(defenders[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      private function handler_addWarrior(param1:String) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < defenders.length)
         {
            if(defenders[_loc2_].userId == param1)
            {
               _defenderListData.addItem(defenders[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      private function handler_fillFortificationWithDefenderConfirm(param1:PromptPopup) : void
      {
         var _loc2_:ClanWarDefenderValueObject = param1.data as ClanWarDefenderValueObject;
         if(_loc2_)
         {
            executeCommandFillFortificationWithDefender(_loc2_);
            close();
         }
         param1.signal_confirm.remove(handler_fillFortificationWithDefenderConfirm);
      }
      
      private function handler_fillFortificationWithDefenderCancel(param1:PromptPopup) : void
      {
         param1.signal_confirm.remove(handler_fillFortificationWithDefenderCancel);
      }
   }
}
