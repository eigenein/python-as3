package game.view.popup.hero
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.rune.PlayerHeroRuneMediator;
   import idv.cjcat.signals.Signal;
   
   public class HeroRuneListItemRenderer extends HeroListItemRendererBase
   {
       
      
      private var colorPlusClip:HeroColorNumberClip;
      
      private const runes:PlayerHeroRuneMediator = new PlayerHeroRuneMediator();
      
      private var _signal_select:Signal;
      
      private var _vo:PlayerHeroListValueObject;
      
      public function HeroRuneListItemRenderer()
      {
         super();
         _signal_select = new Signal(PlayerHeroListValueObject);
         runes.signal_updated.add(handler_runesUpdated);
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get vo() : PlayerHeroListValueObject
      {
         return _vo;
      }
      
      protected function get clip() : HeroRuneListPopupItemClip
      {
         return assetClip as HeroRuneListPopupItemClip;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         if(vo)
         {
            updateNameColor();
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerHeroListValueObject = data as PlayerHeroListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_updateLevel.remove(handler_levelUpdate);
         }
         .super.data = param1;
         _vo = data as PlayerHeroListValueObject;
         if(_vo)
         {
            vo.signal_updateLevel.add(handler_levelUpdate);
            runes.setHero(vo.playerEntry);
         }
         if(clip)
         {
            clip.NewIcon_inst0.graphics.visible = false;
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
         assetClip = AssetStorage.rsx.popup_theme.create_dialog_hero_rune_list_item();
         addChild(assetClip.graphics);
      }
      
      private function updateNameColor() : void
      {
         if(colorPlusClip)
         {
            colorPlusClip.dispose();
         }
         colorPlusClip = HeroColorNumberClip.create(vo.color,true);
         if(colorPlusClip)
         {
            clip.layout_name.addChild(colorPlusClip.graphics);
         }
         clip.tf_hero_name.text = vo.name;
      }
      
      override protected function listener_buttonClick() : void
      {
         _signal_select.dispatch(data as PlayerHeroListValueObject);
      }
      
      private function handler_levelUpdate() : void
      {
         portrait.update_level();
      }
      
      override protected function listener_heroPromote() : void
      {
         super.listener_heroPromote();
         updateNameColor();
      }
      
      private function handler_runesUpdated() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
