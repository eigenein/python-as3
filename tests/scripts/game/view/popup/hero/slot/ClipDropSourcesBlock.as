package game.view.popup.hero.slot
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.data.ListCollection;
   import game.data.storage.chest.ChestDescription;
   import game.data.storage.pve.mission.MissionItemDropValueObject;
   import game.data.storage.resource.InventoryItemObtainType;
   import game.mediator.gui.popup.inventory.ItemInfoPopupMediator;
   import game.mediator.gui.popup.titan.TitanDropSourceInfoClip;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import idv.cjcat.signals.Signal;
   
   public class ClipDropSourcesBlock extends GuiClipNestedContainer
   {
       
      
      private var mediator:ItemInfoPopupMediator;
      
      public var button_obtain:ClipButtonLabeled;
      
      public var tf_drop_label:ClipLabel;
      
      public var drop_list:ClipDropSourcesBlockList;
      
      public var drop_sources_chest:ClipDropSourcesBlockChestClip;
      
      public var titan_obtain_info:TitanDropSourceInfoClip;
      
      private var obtainType:InventoryItemObtainType;
      
      public var tf_drop_label_no_source:ClipLabel;
      
      public var tf_drop_label_no_source_layout:ClipLayout;
      
      public var layout_not_centered:ClipLayout;
      
      private var _signal_obtainClick:Signal;
      
      private var _signal_obtainFromChestClick:Signal;
      
      public function ClipDropSourcesBlock()
      {
         button_obtain = new ClipButtonLabeled();
         tf_drop_label = new ClipLabel();
         drop_list = new ClipDropSourcesBlockList();
         drop_sources_chest = new ClipDropSourcesBlockChestClip();
         titan_obtain_info = new TitanDropSourceInfoClip();
         tf_drop_label_no_source = new ClipLabel();
         tf_drop_label_no_source_layout = ClipLayout.verticalMiddleCenter(0,tf_drop_label_no_source);
         layout_not_centered = ClipLayout.none(button_obtain,drop_sources_chest);
         _signal_obtainClick = new Signal();
         _signal_obtainFromChestClick = new Signal();
         super();
      }
      
      public function get signal_obtainClick() : Signal
      {
         return _signal_obtainClick;
      }
      
      public function get signal_obtainFromChestClick() : Signal
      {
         return _signal_obtainFromChestClick;
      }
      
      public function setMediator(param1:ItemInfoPopupMediator) : void
      {
         this.mediator = param1;
         titan_obtain_info.button_fragment_find_1.signal_click.add(mediator.action_obtainTitanFromDungeon);
         titan_obtain_info.button_fragment_find_2.signal_click.add(mediator.action_obtainTitanFromSummoningCircle);
      }
      
      public function setObtainTypeNone() : void
      {
         titan_obtain_info.graphics.visible = false;
         tf_drop_label_no_source_layout.graphics.visible = true;
         button_obtain.graphics.visible = false;
         drop_list.graphics.visible = false;
         checkNotCenteredElementsAlign();
      }
      
      public function setDropList(param1:Vector.<MissionItemDropValueObject>) : void
      {
         titan_obtain_info.graphics.visible = false;
         drop_sources_chest.graphics.y = 360;
         button_obtain.graphics.visible = false;
         drop_list.graphics.visible = true;
         drop_list.list.dataProvider = new ListCollection(param1);
         checkNotCenteredElementsAlign();
         tf_drop_label.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_DROPLIST");
         tf_drop_label_no_source_layout.graphics.visible = false;
      }
      
      public function setObtainType(param1:InventoryItemObtainType) : void
      {
         this.obtainType = param1;
         drop_list.graphics.visible = false;
         titan_obtain_info.graphics.visible = false;
         tf_drop_label.visible = true;
         tf_drop_label.text = param1.descText;
         if(param1.typeBase == "titan")
         {
            titan_obtain_info.graphics.visible = true;
            button_obtain.graphics.visible = false;
         }
         else if(param1.canNavigateTo)
         {
            tf_drop_label.validate();
            if(param1.typeBase == "chest")
            {
               button_obtain.graphics.visible = false;
               drop_sources_chest.graphics.y = int(tf_drop_label.y + tf_drop_label.graphics.height + 10);
            }
            else
            {
               button_obtain.graphics.visible = true;
               button_obtain.graphics.y = int(tf_drop_label.y + tf_drop_label.graphics.height + 10);
            }
         }
         else
         {
            button_obtain.graphics.visible = false;
         }
         checkNotCenteredElementsAlign();
         tf_drop_label_no_source_layout.graphics.visible = false;
      }
      
      public function setChestType(param1:ChestDescription) : void
      {
         var _loc2_:Number = NaN;
         drop_sources_chest.graphics.visible = param1 != null;
         if(param1)
         {
            drop_sources_chest.tf_chest_label.text = param1.name;
            _loc2_ = drop_sources_chest.graphics.y - drop_list.graphics.y - 1;
            drop_list.setHeight(_loc2_);
         }
         else
         {
            drop_list.setHeight(268);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_obtain.label = Translate.translate("UI_ITEM_INFO_BUTTON_OBTAIN");
         tf_drop_label.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_DROPLIST");
         tf_drop_label.maxHeight = Infinity;
         button_obtain.signal_click.add(handler_buttonClick);
         drop_sources_chest.button.signal_click.add(handler_buttonChestClick);
         drop_sources_chest.button.label = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_DROPLIST_GET");
         tf_drop_label_no_source.text = Translate.translate("UI_HERO_SLOT_ITEM_DROP_SOURCES_TF_DROP_LABEL_NO_SOURCE");
      }
      
      private function handler_buttonClick() : void
      {
         _signal_obtainClick.dispatch();
      }
      
      private function handler_buttonChestClick() : void
      {
         _signal_obtainFromChestClick.dispatch();
      }
      
      private function checkNotCenteredElementsAlign() : void
      {
         if(drop_list.graphics.visible)
         {
            layout_not_centered.x = 0;
         }
         else
         {
            layout_not_centered.x = 10;
         }
      }
   }
}
