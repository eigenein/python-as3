package game.view.popup.hero.consumable
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.data.storage.DataStorage;
   import game.data.storage.level.HeroLevel;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.hero.HeroPortraitClip;
   
   public class HeroUseConsumableWithSelectorHeroOneLevelClipListItem extends HeroUseConsumableWithSelectorHeroBaseClipListItem
   {
       
      
      private var _tooltipMaxLevelVO:TooltipVO;
      
      private var _tooltipOneLevelVO:TooltipVO;
      
      public var button_one_level:ClipButton;
      
      public var portrait_hero:HeroPortraitClip;
      
      public var tf_name:ClipLabel;
      
      public var tf_level_label:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var tf_xp:ClipLabel;
      
      public var tf_xp_max:ClipLabel;
      
      public var bg_xp:ClipSpriteUntouchable;
      
      public var progressbar_xp:ClipProgressBar;
      
      public var layout_name:ClipLayout;
      
      public var layout_level:ClipLayout;
      
      public function HeroUseConsumableWithSelectorHeroOneLevelClipListItem(param1:HeroUseConsumableHeroSignals)
      {
         _tooltipMaxLevelVO = new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_HERO_USE_XP_POTION_TOOLTIP") + "\n" + Translate.translate("UI_DIALOG_HERO_USE_XP_POTION_DESC"));
         _tooltipOneLevelVO = new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_HERO_RUNE_ENCHANT_LEVEL"));
         button_one_level = new ClipButton();
         tf_name = new ClipLabel();
         tf_level_label = new ClipLabel(true);
         tf_level = new ClipLabel(true);
         tf_xp = new ClipLabel();
         tf_xp_max = new ClipLabel();
         bg_xp = new ClipSpriteUntouchable();
         progressbar_xp = new ClipProgressBar();
         layout_name = ClipLayout.none(tf_name);
         layout_level = ClipLayout.horizontalMiddleCentered(3,tf_level_label,tf_level);
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TooltipHelper.removeTooltip(button_one_level.graphics);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_bg.signal_click.add(handler_bgClick);
         button_bg.signal_hold.add(handler_bgClick);
         button_one_level.signal_click.add(handler_oneLevelCick);
         layout_name.touchable = false;
         layout_level.touchable = false;
         progressbar_xp.graphics.touchable = false;
         tf_xp.touchable = false;
         tf_xp_max.touchable = false;
         tf_level_label.text = Translate.translateArgs("UI_DIALOG_HERO_LEVEL_LABEL");
         tf_xp_max.text = Translate.translateArgs("UI_DIALOG_HERO_USE_CONSUMABLE_LV_MAX");
         TooltipHelper.addTooltip(button_one_level.graphics,_tooltipOneLevelVO);
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         if(this.data)
         {
            portrait_hero.portrait.data = data;
            tf_name.text = data.name;
         }
      }
      
      override protected function setExp(param1:int) : void
      {
         var _loc3_:* = NaN;
         super.setExp(param1);
         var _loc4_:HeroLevel = DataStorage.level.getHeroLevelByExp(param1);
         if(_loc4_ && _loc4_.nextLevel)
         {
            _loc3_ = Number((param1 - _loc4_.exp) / (_loc4_.nextLevel.exp - _loc4_.exp));
         }
         else
         {
            _loc3_ = 1;
         }
         progressbar_xp.value = _loc3_;
         tf_level.text = String(_loc4_.level);
         var _loc2_:* = param1 >= data.maxExperience;
         if(_loc2_)
         {
            TooltipHelper.addTooltip(graphics,_tooltipMaxLevelVO);
         }
         else
         {
            TooltipHelper.removeTooltip(graphics);
            tf_xp.text = data.exp + " / " + data.expNextLvl;
         }
         var _loc5_:* = !_loc2_;
         button_one_level.isEnabled = _loc5_;
         button_bg.isEnabled = _loc5_;
         progressbar_xp.graphics.visible = !_loc2_;
         tf_xp.graphics.visible = !_loc2_;
         bg_xp.graphics.visible = !_loc2_;
         tf_xp_max.graphics.visible = _loc2_;
         portrait_hero.portrait.update_level();
      }
   }
}
