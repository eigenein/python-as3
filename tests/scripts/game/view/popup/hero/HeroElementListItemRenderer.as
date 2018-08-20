package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroElementListItemRenderer extends HeroListItemRendererBase
   {
       
      
      public var tf_hero_name:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      private var _vo:PlayerHeroListValueObject;
      
      private var _signal_select:Signal;
      
      public function HeroElementListItemRenderer()
      {
         tf_hero_name = new ClipLabel(true);
         layout_name = ClipLayout.horizontalCentered(2,tf_hero_name);
         _signal_select = new Signal(PlayerHeroListValueObject);
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_vo)
         {
            _vo.playerEntry.signal_titanGiftLevelChange.remove(handler_titanGiftLevelChange);
            _vo.signal_updateTitanGiftLevelUpAvailable.remove(handler_titanGiftLevelUpAvaliableChange);
         }
      }
      
      protected function get clip() : HeroElementListPopupItemClip
      {
         return assetClip as HeroElementListPopupItemClip;
      }
      
      public function get vo() : PlayerHeroListValueObject
      {
         return _vo;
      }
      
      override public function set data(param1:Object) : void
      {
         .super.data = param1;
         if(_vo)
         {
            _vo.playerEntry.signal_titanGiftLevelChange.remove(handler_titanGiftLevelChange);
            _vo.signal_updateTitanGiftLevelUpAvailable.remove(handler_titanGiftLevelUpAvaliableChange);
         }
         _vo = data as PlayerHeroListValueObject;
         if(!_vo)
         {
            return;
         }
         if(_vo)
         {
            _vo.playerEntry.signal_titanGiftLevelChange.add(handler_titanGiftLevelChange);
            _vo.signal_updateTitanGiftLevelUpAvailable.add(handler_titanGiftLevelUpAvaliableChange);
         }
         invalidate("data");
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override protected function draw() : void
      {
         var _loc1_:* = 0;
         super.draw();
         if(isInvalid("data") && vo)
         {
            if(clip)
            {
               _loc1_ = uint(DataStorage.titanGift.getTitanGiftWithMaxLevel().level);
               clip.tf_hero_name.text = vo.name;
               clip.tf_hero_level.text = Translate.translateArgs("UI_COMMON_LEVEL",ColorUtils.hexToRGBFormat(16645626) + vo.playerEntry.titanGiftLevel + "/" + _loc1_);
               clip.red_dot.graphics.visible = vo.titanGiftLevelUpAvaliable;
               clip.progress.minValue = 0;
               clip.progress.maxValue = _loc1_;
               clip.progress.value = vo.playerEntry.titanGiftLevel;
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = clip.bg_button.graphics.width;
         height = clip.bg_button.graphics.height;
      }
      
      override protected function createClip() : void
      {
         assetClip = AssetStorage.rsx.popup_theme.create_dialog_hero_element_list_item();
         addChild(assetClip.graphics);
      }
      
      override protected function listener_buttonClick() : void
      {
         _signal_select.dispatch(data as PlayerHeroListValueObject);
      }
      
      private function handler_titanGiftLevelChange(param1:PlayerHeroEntry) : void
      {
         invalidate("data");
      }
      
      private function handler_titanGiftLevelUpAvaliableChange() : void
      {
         if(clip)
         {
            clip.red_dot.graphics.visible = vo && vo.titanGiftLevelUpAvaliable;
         }
      }
   }
}
