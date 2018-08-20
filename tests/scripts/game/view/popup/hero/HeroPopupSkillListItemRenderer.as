package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipLabel;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.controls.Label;
   import feathers.layout.HorizontalLayout;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.skill.HeroPopupSkillValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.TutorialClipButton;
   import game.view.gui.components.tooltip.SkillTooltip;
   import game.view.popup.theme.LabelStyle;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class HeroPopupSkillListItemRenderer extends GuiClipNestedContainer implements ITooltipSource
   {
       
      
      private var levelNameLabel:Label;
      
      private var oddIndex:Boolean;
      
      private var levelNumberLabel:Label;
      
      private var _tooltipVO:TooltipVO;
      
      public var label_title:GuiClipLabel;
      
      public var label_cost:GuiClipLabel;
      
      public var icon_coin:ClipSprite;
      
      public var lock_icon:ClipSprite;
      
      public var label_lock_desc:GuiClipLabel;
      
      public var button_upgrade:TutorialClipButton;
      
      public var image_frame:GuiClipImage;
      
      public var image_item:GuiClipImage;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var level_layout_container:GuiClipLayoutContainer;
      
      private var _data:HeroPopupSkillValueObject;
      
      private var _signal_skillUpgrade:Signal;
      
      public function HeroPopupSkillListItemRenderer()
      {
         _tooltipVO = new TooltipVO(SkillTooltip,null);
         button_upgrade = new TutorialClipButton(22.5,22.5,50);
         super();
         label_lock_desc = new GuiClipLabel(LabelStyle.label_size16_multiline);
         label_title = new GuiClipLabel(LabelStyle.label_size18);
         label_cost = new GuiClipLabel(LabelStyle.label_size20);
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         _signal_skillUpgrade = new Signal(HeroPopupSkillValueObject);
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get data() : HeroPopupSkillValueObject
      {
         return _data;
      }
      
      public function set data(param1:HeroPopupSkillValueObject) : void
      {
         var _loc2_:HeroPopupSkillValueObject = data as HeroPopupSkillValueObject;
         if(_loc2_)
         {
            _loc2_.updateSignal.remove(onDataUpdate);
         }
         _data = param1;
         _loc2_ = _data as HeroPopupSkillValueObject;
         commitData();
         if(_loc2_)
         {
            _loc2_.updateSignal.add(onDataUpdate);
         }
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      public function get signal_skillUpgrade() : Signal
      {
         return _signal_skillUpgrade;
      }
      
      protected function commitData() : void
      {
         var _loc1_:HeroPopupSkillValueObject = data as HeroPopupSkillValueObject;
         if(_loc1_)
         {
            label_title.text = _loc1_.name;
            adjustTitleSize(_loc1_.name);
            image_frame.image.texture = _loc1_.qualityFrameTexture;
            image_item.image.texture = _loc1_.icon;
            levelNumberLabel.text = _loc1_.level.toString();
            button_upgrade.graphics.visible = _loc1_.canUpgrade;
            var _loc2_:* = _loc1_.canUpgrade;
            icon_coin.graphics.visible = _loc2_;
            label_cost.graphics.visible = _loc2_;
            if(!_loc1_.available)
            {
               image_item.graphics.filter = AssetStorage.rsx.popup_theme.filter_disabled;
               label_lock_desc.text = _loc1_.lockedTextDesc;
            }
            else if(image_item.graphics.filter)
            {
               image_item.graphics.filter.dispose();
               image_item.graphics.filter = null;
            }
            _loc2_ = !_loc1_.available;
            lock_icon.graphics.visible = _loc2_;
            label_lock_desc.graphics.visible = _loc2_;
            _loc2_ = _loc1_.available;
            levelNumberLabel.visible = _loc2_;
            levelNameLabel.visible = _loc2_;
            if(_loc1_.upgradeCost)
            {
               label_cost.text = _loc1_.upgradeCost.gold.toString();
            }
            _tooltipVO.hintData = _loc1_.tooltipValueObject;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:HorizontalLayout = new HorizontalLayout();
         _loc2_.gap = 3;
         level_layout_container.layoutGroup.layout = _loc2_;
         levelNameLabel = LabelStyle.label_size18();
         levelNameLabel.text = Translate.translate("UI_DIALOG_HERO_SKILL_LEVEL");
         level_layout_container.container.addChild(levelNameLabel);
         levelNumberLabel = LabelStyle.label_size18_white();
         level_layout_container.container.addChild(levelNumberLabel);
         button_upgrade.signal_click.add(buttonUpgradeClick);
      }
      
      private function adjustTitleSize(param1:String) : void
      {
         var _loc3_:* = param1.length > 18;
         var _loc2_:* = label_title.label.textRendererProperties.textFormat.size == 16;
         if(_loc3_ != _loc2_)
         {
            if(_loc3_)
            {
               label_title.label.textRendererProperties.textFormat = LabelStyle.textFormat_size16();
            }
            else
            {
               label_title.label.textRendererProperties.textFormat = LabelStyle.textFormat_size18();
            }
         }
      }
      
      private function buttonUpgradeClick() : void
      {
         var _loc1_:HeroPopupSkillValueObject = data as HeroPopupSkillValueObject;
         if(_loc1_)
         {
            signal_skillUpgrade.dispatch(_loc1_);
         }
      }
      
      private function onDataUpdate() : void
      {
         commitData();
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
