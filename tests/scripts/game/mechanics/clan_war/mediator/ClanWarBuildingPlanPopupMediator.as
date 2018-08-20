package game.mechanics.clan_war.mediator
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mechanics.clan_war.model.ClanWarPlanSlotValueObject;
   import game.mechanics.clan_war.popup.plan.building.ClanWarBuildingPlanPopup;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class ClanWarBuildingPlanPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var buildingDesc:ClanWarFortificationDescription;
      
      public var defenderListData:ListCollection;
      
      private var _text_desc:String;
      
      public function ClanWarBuildingPlanPopupMediator(param1:Player, param2:ClanWarFortificationDescription, param3:Vector.<ClanWarPlanSlotValueObject>)
      {
         super(param1);
         this.buildingDesc = param2;
         defenderListData = new ListCollection();
         var _loc6_:int = 0;
         var _loc5_:* = param3;
         for each(var _loc4_ in param3)
         {
            if(_loc4_.desc.fortificationId == param2.id)
            {
               defenderListData.addItem(_loc4_);
            }
         }
      }
      
      public function get text_desc() : String
      {
         return Translate.translateArgs("UI_POPUP_BUILDING_SELECTED_TF_DESC",buildingDesc.pointReward);
      }
      
      public function get text_header() : String
      {
         return Translate.translateArgs("UI_POPUP_BUILDING_SELECTED_TF_HEADER",buildingDesc.name);
      }
      
      public function action_remove(param1:ClanWarPlanSlotValueObject) : void
      {
         player.clan.clanWarData.action_removeDefender(param1);
      }
      
      public function action_select(param1:ClanWarPlanSlotValueObject) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:* = null;
         if(param1.playerIsAdmin)
         {
            _loc3_ = player.clan.clanWarData.action_filterDefenders(param1);
            _loc2_ = new ClanWarSelectDefenderPopupMediator(player,param1,_loc3_);
            _loc2_.open(Stash.click("slot:" + param1.desc.id,_popup.stashParams));
         }
         else
         {
            player.clan.clanWarData.action_fillFortificationWithPlayer(param1);
            close();
         }
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarBuildingPlanPopup(this);
         return _popup;
      }
   }
}
