package game.view.popup.hero.skins
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.skin.HeroPopupSkinValueObject;
   import game.mediator.gui.popup.hero.skin.SkinListItemRendererMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.Image;
   
   public class SkinListItemRenderer extends ListItemRenderer
   {
       
      
      private var starImages:Object;
      
      private var clip:SkinListItemClip;
      
      private var mediator:SkinListItemRendererMediator;
      
      private var actionButtonHover:TouchHoverContoller;
      
      private var clickController:TouchClickController;
      
      private var tooltipVO:TooltipVO;
      
      public function SkinListItemRenderer()
      {
         starImages = {};
         super();
         mediator = new SkinListItemRendererMediator();
         mediator.signal_change.add(onDataChange);
         mediator.signal_upgrade.add(onSkinUpgrade);
         tooltipVO = new TooltipVO(TooltipTextView,null);
      }
      
      override public function set data(param1:Object) : void
      {
         .super.data = param1;
      }
      
      private function onSkinUpgrade() : void
      {
         onDataChange();
         clip.animation.show(clip.container);
         clip.animation.playOnceAndHide();
      }
      
      private function onDataChange() : void
      {
         invalidate("data");
      }
      
      override protected function draw() : void
      {
         if(isInvalid("selected") && mediator && mediator.skinVO)
         {
            clip.browes_icon.graphics.visible = mediator.level == 0 && !mediator.isDefault && isSelected;
            clip.bg_selected.graphics.visible = isSelected;
            clip.bg.graphics.touchable = !isSelected;
            if(isSelected)
            {
               clip.title_tf.text = ColorUtils.hexToRGBFormat(16645626) + Translate.translate(mediator.localeKey);
            }
            else
            {
               clip.title_tf.text = ColorUtils.hexToRGBFormat(16573879) + Translate.translate(mediator.localeKey);
            }
         }
         super.draw();
      }
      
      override public function dispose() : void
      {
         data = null;
         clip.dispose();
         actionButtonHover.dispose();
         clickController.dispose();
         mediator.signal_change.remove(onDataChange);
         mediator.signal_upgrade.remove(onSkinUpgrade);
         mediator.dispose();
         TooltipHelper.removeTooltip(this);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_skin_list_item();
         addChild(clip.graphics);
         actionButtonHover = new TouchHoverContoller(clip.action_button.container);
         actionButtonHover.signal_hoverChanger.add(handler_actionButtonHoverChanged);
         clickController = new TouchClickController(clip.bg.container);
         clickController.onClick.add(onClick);
         clip.action_button.signal_click.add(action_buttonTriggered);
         clip.btn_event.signal_click.add(mediator.navigateToObtain);
         clip.btn_unlock.label = Translate.translate("UI_DIALOG_HERO_GUISE_UNLOCK");
         clip.btn_unlock.signal_click.add(mediator.action_showSkinUnlockPopup);
         clip.animation.hide();
         clip.animation.stop();
         clip.browes_icon.graphics.visible = false;
         clip.bg_selected.graphics.visible = false;
         clip.title_tf.touchable = false;
         clip.lock_icon.graphics.touchable = false;
         clip.browes_icon.graphics.touchable = false;
         clip.check_icon.graphics.touchable = false;
         clip.bg_selected.graphics.touchable = false;
         clip.description_layout.touchable = false;
         clip.line2.graphics.touchable = false;
         clip.image_item.container.touchable = false;
         clip.border.container.touchable = false;
         clip.action_tf.touchable = false;
         clip.event_tf.text = Translate.translate("LIB_EVENT_SKIN_DESC");
         TooltipHelper.addTooltip(clip.action_button.graphics,tooltipVO);
      }
      
      private function onClick() : void
      {
         isSelected = true;
         if(mediator.level > 0 || mediator.isDefault)
         {
            mediator.skinChange();
         }
      }
      
      private function handler_actionButtonHoverChanged() : void
      {
         if(mediator.level > 0)
         {
            showHoverEffect();
         }
      }
      
      override protected function commitData() : void
      {
         var _loc1_:* = false;
         var _loc4_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc5_:* = null;
         var _loc3_:* = null;
         super.commitData();
         mediator.skinVO = data as HeroPopupSkinValueObject;
         if(mediator.skinVO)
         {
            this.visible = mediator.rendererVisible;
            if(!this.visible)
            {
               return;
            }
            if(mediator.heroCurrentSkin == 0 && mediator.isDefault || mediator.heroCurrentSkin == mediator.skinID)
            {
               isSelected = true;
            }
            invalidate("selected");
            clip.lock_icon.graphics.visible = mediator.level == 0 && !mediator.isDefault;
            clip.check_bg.graphics.visible = !clip.lock_icon.graphics.visible;
            clip.check_icon.graphics.visible = Boolean(mediator.heroCurrentSkin == 0 && mediator.isDefault || mediator.heroCurrentSkin == mediator.skinID);
            _loc1_ = mediator.billing != null;
            if(mediator.eventID && mediator.level == 0)
            {
               _loc4_ = false;
               _loc2_ = mediator.specialOfferIsActive;
               if(_loc2_)
               {
                  clip.btn_event.label = mediator.eventTitle;
               }
               clip.btn_event.graphics.visible = _loc2_;
               clip.event_tf.visible = !_loc2_;
            }
            else if(mediator.upgradeCost == null && mediator.level == 0)
            {
               _loc4_ = false;
               clip.btn_event.label = mediator.actionText;
               clip.btn_event.graphics.visible = true;
               clip.event_tf.visible = false;
            }
            else
            {
               _loc4_ = true;
               clip.btn_event.graphics.visible = false;
               clip.event_tf.visible = false;
            }
            clip.btn_unlock.graphics.visible = _loc4_ && _loc1_ && mediator.level == 0;
            clip.action_tf.visible = _loc4_ && !clip.btn_unlock.graphics.visible;
            clip.action_button.graphics.visible = _loc4_ && !clip.btn_unlock.graphics.visible;
            if(clip.action_button.graphics.visible)
            {
               clip.action_tf.text = mediator.actionText;
               if(mediator.level < mediator.maxLevel)
               {
                  _loc5_ = mediator.upgradeCost;
                  if(_loc5_)
                  {
                     clip.action_button.cost = _loc5_;
                  }
                  clip.action_tf.width = 145;
                  clip.action_button.graphics.visible = true;
               }
               else
               {
                  clip.action_tf.width = 255;
                  clip.action_button.graphics.visible = false;
               }
            }
            _loc3_ = new Image(mediator.icon);
            _loc3_.width = 72;
            _loc3_.height = 72;
            clip.image_item.container.removeChildren(0,-1,true);
            clip.image_item.container.addChild(_loc3_);
            updateDescription();
         }
      }
      
      private function showHoverEffect() : void
      {
      }
      
      private function updateDescription() : void
      {
         clip.stat_tf.text = mediator.getSkinDescriptionByLevel(mediator.level);
         clip.level_tf.text = mediator.levelText;
         var _loc1_:* = mediator.level > 0;
         clip.level_tf.includeInLayout = _loc1_;
         clip.level_tf.visible = _loc1_;
         tooltipVO.hintData = mediator.tooltipText;
      }
      
      protected function action_buttonTriggered() : void
      {
         mediator.skinUpgrade();
      }
   }
}
