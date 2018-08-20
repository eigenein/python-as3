package game.view.popup.hero
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.assets.RequestableAsset;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.element.PlayerHeroElementMediator;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.hero.rune.HeroElementPopupCircleClip;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroPopupElementTab extends GuiClipNestedContainer
   {
       
      
      private var needUpdate:Boolean = false;
      
      private var circleClip:HeroElementPopupCircleClip;
      
      private var _mediator:PlayerHeroElementMediator;
      
      public var tf_title:SpecialClipLabel;
      
      public var tf_skill1:ClipLabel;
      
      public var tf_skill2:ClipLabel;
      
      public var tf_skill3:ClipLabel;
      
      public var tf_skill1_value:SpecialClipLabel;
      
      public var tf_skill2_value:SpecialClipLabel;
      
      public var tf_skill3_value:SpecialClipLabel;
      
      public var skill1_container:ClipLayout;
      
      public var skill2_container:ClipLayout;
      
      public var skill3_container:ClipLayout;
      
      public var tf_label1:ClipLabel;
      
      public var tf_label2:ClipLabel;
      
      public var btn_action_1:ClipButtonLabeled;
      
      public var btn_action_2:ClipButtonLabeled;
      
      public var red_marker:ClipSprite;
      
      public var circle_container:ClipLayout;
      
      public function HeroPopupElementTab()
      {
         tf_title = new SpecialClipLabel();
         tf_skill1 = new ClipLabel();
         tf_skill2 = new ClipLabel();
         tf_skill3 = new ClipLabel();
         tf_skill1_value = new SpecialClipLabel();
         tf_skill2_value = new SpecialClipLabel();
         tf_skill3_value = new SpecialClipLabel();
         skill1_container = ClipLayout.anchor();
         skill2_container = ClipLayout.anchor();
         skill3_container = ClipLayout.anchor();
         tf_label1 = new ClipLabel();
         tf_label2 = new ClipLabel();
         circle_container = ClipLayout.horizontalCentered(0);
         super();
      }
      
      public function dispose() : void
      {
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetClanCircle);
      }
      
      public function get mediator() : PlayerHeroElementMediator
      {
         return _mediator;
      }
      
      public function set mediator(param1:PlayerHeroElementMediator) : void
      {
         _mediator = param1;
         _mediator.signal_updateTitanGiftLevelUpAvaliable.add(updateRedMarker);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(!circleClip)
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.asset_clan_circle,handler_assetClanCircle);
         }
         tf_label1.text = Translate.translate("UI_DIALOG_HERO_ELEMENT_TEXT1");
         tf_label2.text = Translate.translate("UI_DIALOG_HERO_ELEMENT_TEXT2");
         btn_action_1.label = Translate.translate("UI_DIALOG_HERO_ELEMENT_NAVIGATE_TO_CLAN");
         btn_action_2.label = Translate.translate("UI_DIALOG_HERO_ELEMENT_NAVIGATE_TO_TITAN");
         btn_action_1.signal_click.add(handler_navigateToClan);
         btn_action_2.signal_click.add(handler_navigateToTitan);
      }
      
      public function update() : void
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         if(circleClip == null)
         {
            needUpdate = true;
            return;
         }
         circleClip.setLevel(mediator.heroTitanGiftLevel);
         updateRedMarker();
         var _loc1_:int = mediator.heroGiftLevelMax;
         if(mediator.heroTitanGiftLevel == _loc1_)
         {
            _loc4_ = mediator.battleStatsCurrent;
            tf_title.text = Translate.translate("UI_COMMON_LEVEL_MAX");
         }
         else
         {
            _loc4_ = mediator.battleStatsCurrent;
            tf_title.text = ColorUtils.hexToRGBFormat(16381667) + Translate.translateArgs("UI_COMMON_LEVEL",mediator.heroTitanGiftLevel + "/" + _loc1_);
         }
         var _loc6_:Object = _loc4_.serialize();
         if(_loc6_)
         {
            _loc8_ = [];
            var _loc10_:int = 0;
            var _loc9_:* = _loc6_;
            for(var _loc2_ in _loc6_)
            {
               _loc8_.push(_loc2_);
            }
            if(_loc8_.length > 0 && _loc6_[_loc8_[0]])
            {
               tf_skill1.text = Translate.translate("LIB_BATTLESTATDATA_" + _loc8_[0].toUpperCase());
               skill1_container.removeChildren();
               _loc7_ = new ClipSprite();
               AssetStorage.rsx.rune_icons.initGuiClip(_loc7_,_loc8_[0].toLowerCase());
               skill1_container.addChild(_loc7_.graphics);
            }
            if(_loc8_.length > 1 && _loc6_[_loc8_[1]])
            {
               tf_skill2.text = Translate.translate("LIB_BATTLESTATDATA_" + _loc8_[1].toUpperCase());
               skill2_container.removeChildren();
               _loc5_ = new ClipSprite();
               AssetStorage.rsx.rune_icons.initGuiClip(_loc5_,_loc8_[1].toLowerCase());
               skill2_container.addChild(_loc5_.graphics);
            }
            if(_loc8_.length > 2 && _loc6_[_loc8_[2]])
            {
               tf_skill3.text = Translate.translate("LIB_BATTLESTATDATA_" + _loc8_[2].toUpperCase());
               skill3_container.removeChildren();
               _loc3_ = new ClipSprite();
               AssetStorage.rsx.rune_icons.initGuiClip(_loc3_,_loc8_[2].toLowerCase());
               skill3_container.addChild(_loc3_.graphics);
            }
            if(mediator.heroTitanGiftLevel > mediator.heroGiftLevelMin)
            {
               if(_loc8_.length > 0 && _loc6_[_loc8_[0]])
               {
                  tf_skill1_value.text = ColorUtils.hexToRGBFormat(16645626) + " +" + _loc6_[_loc8_[0]];
               }
               if(_loc8_.length > 1 && _loc6_[_loc8_[1]])
               {
                  tf_skill2_value.text = ColorUtils.hexToRGBFormat(16645626) + " +" + _loc6_[_loc8_[1]];
               }
               if(_loc8_.length > 2 && _loc6_[_loc8_[2]])
               {
                  tf_skill3_value.text = ColorUtils.hexToRGBFormat(16645626) + " +" + _loc6_[_loc8_[2]];
               }
            }
            else
            {
               tf_skill1_value.text = ColorUtils.hexToRGBFormat(16645626) + " 0";
               tf_skill2_value.text = ColorUtils.hexToRGBFormat(16645626) + " 0";
               tf_skill3_value.text = ColorUtils.hexToRGBFormat(16645626) + " 0";
            }
         }
      }
      
      private function updateRedMarker() : void
      {
         red_marker.graphics.visible = mediator.actionAvailable_titanGiftLevelUp;
      }
      
      private function handler_assetClanCircle(param1:RequestableAsset) : void
      {
         circleClip = AssetStorage.rsx.asset_clan_circle.create(HeroElementPopupCircleClip,"circle_with_pyramids");
         var _loc2_:* = 0.67;
         circleClip.graphics.scaleY = _loc2_;
         circleClip.graphics.scaleX = _loc2_;
         circle_container.addChild(circleClip.graphics);
         if(needUpdate)
         {
            update();
            needUpdate = false;
         }
      }
      
      private function handler_navigateToTitan() : void
      {
         mediator.action_navigate_to_titan();
      }
      
      private function handler_navigateToClan() : void
      {
         mediator.action_navigate_to_clan();
      }
   }
}
