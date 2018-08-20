package game.mechanics.clan_war.mediator
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   import game.mechanics.clan_war.popup.war.ClanWarDefensePopup;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class ClanWarDefensePopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var buildingDesc:ClanWarFortificationDescription;
      
      private var _defenderListData:ListCollection;
      
      public function ClanWarDefensePopupMediator(param1:Player, param2:ClanWarFortificationDescription, param3:Vector.<ClanWarSlotValueObject>)
      {
         super(param1);
         this.buildingDesc = param2;
         _defenderListData = new ListCollection();
         var _loc6_:int = 0;
         var _loc5_:* = param3;
         for each(var _loc4_ in param3)
         {
            defenderListData.addItem(_loc4_);
         }
      }
      
      public function get text_header() : String
      {
         return Translate.translateArgs("UI_POPUP_BUILDING_SELECTED_DEFENSE_TF_HEADER",buildingDesc.name);
      }
      
      public function get defenderListData() : ListCollection
      {
         return _defenderListData;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarDefensePopup(this);
         return _popup;
      }
   }
}
