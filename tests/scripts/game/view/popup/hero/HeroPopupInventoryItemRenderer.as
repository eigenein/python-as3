package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.slot.HeroInventorySlotValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.DataClipButton;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.chest.SoundGuiAnimation;
   import starling.events.Event;
   
   public class HeroPopupInventoryItemRenderer extends DataClipButton implements ITooltipSource
   {
      
      private static const INVALIDATION_FLAG_FILLABLE:String = "INVALIDATION_FLAG_FILLABLE";
       
      
      private var _data:HeroInventorySlotValueObject;
      
      public var image_plus:GuiAnimation;
      
      public var bang:SoundGuiAnimation;
      
      public var image_plus_seek:ClipSprite;
      
      public var image_plus_yellow:ClipSprite;
      
      public var image_frame:GuiClipImage;
      
      public var image_item:GuiClipImage;
      
      public var black_text_bg:ClipSprite;
      
      public var tf_level_red:ClipLabel;
      
      public var tf_action:ClipLabel;
      
      protected var _tooltipVO:TooltipVO;
      
      public function HeroPopupInventoryItemRenderer()
      {
         black_text_bg = new ClipSprite();
         tf_level_red = new ClipLabel();
         tf_action = new ClipLabel();
         super(HeroPopupInventoryItemRenderer);
         _tooltipVO = new TooltipVO(TooltipTextView,null);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         bang.stop();
         bang.hide();
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
         black_text_bg.graphics.width = 73;
         black_text_bg.graphics.height = 22;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(_data)
         {
            _data.signal_updateSlotState.remove(onDataUpdate);
         }
         _data = param1 as HeroInventorySlotValueObject;
         if(_data)
         {
            _data.signal_updateSlotState.add(onDataUpdate);
         }
         commitData();
      }
      
      override protected function playClickSound() : void
      {
         if(_data.slotState != 1)
         {
            super.playClickSound();
         }
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override protected function getClickData() : *
      {
         return this;
      }
      
      protected function commitData() : void
      {
         var _loc1_:* = false;
         var _loc2_:HeroInventorySlotValueObject = data as HeroInventorySlotValueObject;
         if(_loc2_)
         {
            updatePlusIcon();
            image_frame.image.texture = _loc2_.qualityFrame;
            image_item.image.texture = _loc2_.icon;
            _loc1_ = _loc2_.slotState == 2;
            AssetStorage.rsx.popup_theme.setDisabledFilter(image_item.image,!_loc1_);
            _tooltipVO.hintData = _loc2_.name;
         }
      }
      
      private function updatePlusIcon() : void
      {
         var _loc1_:HeroInventorySlotValueObject = data as HeroInventorySlotValueObject;
         if(_loc1_ && image_plus)
         {
            tf_action.visible = false;
            tf_level_red.visible = false;
            image_plus.graphics.visible = false;
            image_plus_seek.graphics.visible = false;
            image_plus_yellow.graphics.visible = false;
            switch(int(_loc1_.slotState) - 1)
            {
               case 0:
                  image_plus.graphics.visible = true;
                  tf_action.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_INSERT");
                  tf_action.visible = true;
                  break;
               default:
                  image_plus.graphics.visible = true;
                  tf_action.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_INSERT");
                  tf_action.visible = true;
                  break;
               case 2:
                  tf_action.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_SEEK");
                  image_plus_seek.graphics.visible = true;
                  tf_action.visible = true;
                  break;
               case 3:
                  image_plus.graphics.visible = true;
                  tf_action.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_CRAFT");
                  tf_action.visible = true;
                  break;
               case 4:
                  image_plus_yellow.graphics.visible = true;
                  tf_level_red.text = Translate.translateArgs("UI_DIALOG_HERO_INVENTORY_SLOT_NEED_LVL",_loc1_.requiredLevel);
                  tf_level_red.visible = true;
            }
            tf_action.adjustSizeToFitWidth();
            black_text_bg.graphics.visible = tf_action.visible || tf_level_red.visible;
         }
      }
      
      private function onDataUpdate() : void
      {
         commitData();
         var _loc1_:HeroInventorySlotValueObject = data as HeroInventorySlotValueObject;
         if(_loc1_ && _loc1_.slotState == 2)
         {
            bang.show(container);
            bang.playOnceAndHide();
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.addSource(this);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.removeSource(this);
      }
   }
}
