package game.mechanics.clan_war.popup
{
   import com.progrestar.framework.ares.core.Node;
   import game.mechanics.clan_war.model.ClanWarPlanSlotValueObject;
   import game.mechanics.clan_war.model.ClanWarSlotBase;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.view.gui.components.DataClipButton;
   
   public class ClanWarBuildingButton extends DataClipButton
   {
       
      
      protected var desc:ClanWarFortificationDescription;
      
      protected var warSlot:ClanWarSlotBase;
      
      public var building:ClanWarBuildingButtonGraphic;
      
      public var label:ClanWarMapBuildingLabelBase;
      
      public function ClanWarBuildingButton()
      {
         super(ClanWarFortificationDescription);
      }
      
      public function dispose() : void
      {
         label.dispose();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         building.over.graphics.visible = false;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "hover")
         {
            building.over.graphics.visible = true;
         }
         else
         {
            building.over.graphics.visible = false;
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      public function setData_WarSlotVO(param1:Vector.<ClanWarSlotValueObject>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         label.layout_teams.removeChildren();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            setDataForSlotIndex(_loc3_,param1[_loc3_]);
            _loc3_++;
         }
      }
      
      public function setData_PlanSlotVO(param1:Vector.<ClanWarPlanSlotValueObject>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         label.layout_teams.removeChildren();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            setDataForSlotIndex(_loc3_,param1[_loc3_]);
            _loc3_++;
         }
      }
      
      public function setDesc(param1:ClanWarFortificationDescription) : void
      {
         this.desc = param1;
         label.tf_header.text = param1.name;
      }
      
      override protected function getClickData() : *
      {
         return desc;
      }
      
      protected function setDataForSlotIndex(param1:int, param2:ClanWarSlotBase) : void
      {
         this.warSlot = param2;
         label.setDataForSlotIndex(param1,param2);
      }
   }
}
