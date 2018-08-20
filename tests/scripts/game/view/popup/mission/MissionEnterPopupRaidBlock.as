package game.view.popup.mission
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.Label;
   import feathers.controls.LayoutGroup;
   import feathers.display.Scale9Image;
   import feathers.layout.HorizontalLayout;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.mission.MissionEnterPopupMediator;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.popup.theme.LabelStyle;
   
   public class MissionEnterPopupRaidBlock extends LayoutGroup
   {
       
      
      private var mediator:MissionEnterPopupMediator;
      
      private var statusLabel:Label;
      
      private var raidBtn:ClipButtonLabeled;
      
      private var raidBtnMulti:ClipButtonLabeled;
      
      private var raidBtnMax:ClipButtonLabeled;
      
      public function MissionEnterPopupRaidBlock(param1:MissionEnterPopupMediator)
      {
         super();
         this.mediator = param1;
         param1.signal_raidUpdate.add(onRaidDataUpdate);
      }
      
      override public function dispose() : void
      {
         mediator.signal_raidUpdate.remove(onRaidDataUpdate);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         backgroundSkin = new Scale9Image(AssetStorage.rsx.popup_theme.getScale9Textures("enemiesloot_panel_BG_12_12_12_12",new Rectangle(12,12,12,12)));
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         layout = _loc1_;
         _loc1_.gap = 5;
         statusLabel = LabelStyle.label_size18_white();
         addChild(statusLabel);
         statusLabel.text = Translate.translateArgs("UI_DIALOG_MISSION_RAID_DESC");
         raidBtn = AssetStorage.rsx.popup_theme.button_label18();
         raidBtn.signal_click.add(click_raid);
         raidBtn.label = Translate.translate("UI_DIALOG_MISSION_RAID");
         addChild(raidBtn.graphics);
         if(!mediator.isElite)
         {
            raidBtnMulti = AssetStorage.rsx.popup_theme.button_label18();
            raidBtnMulti.signal_click.add(click_raidMultiple);
            addChild(raidBtnMulti.graphics);
         }
         raidBtnMax = AssetStorage.rsx.popup_theme.button_label18();
         raidBtnMax.signal_click.add(click_raidMax);
         addChild(raidBtnMax.graphics);
         commitData();
      }
      
      private function commitData() : void
      {
         if(raidBtnMulti)
         {
            raidBtnMulti.graphics.visible = mediator.raidMultipleCount > 0;
            raidBtnMulti.label = Translate.translateArgs("UI_DIALOG_MISSION_RAID_N",mediator.raidMultipleCount);
         }
         raidBtnMax.graphics.visible = mediator.raidMaxCount > 0;
         raidBtnMax.label = Translate.translateArgs("UI_DIALOG_MISSION_RAID_N",mediator.raidMaxCount);
      }
      
      private function click_raid() : void
      {
         mediator.action_raid();
      }
      
      private function click_raidMultiple() : void
      {
         mediator.action_raidMultuple();
      }
      
      private function click_raidMax() : void
      {
         mediator.action_raidMax();
      }
      
      private function onRaidDataUpdate() : void
      {
         commitData();
      }
   }
}
