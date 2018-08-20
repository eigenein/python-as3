package game.view.popup.hero
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class HeroListItemRendererBase extends ListItemRenderer
   {
       
      
      protected var portrait:HeroPortrait;
      
      protected var assetClip:HeroListItemClipBase;
      
      public function HeroListItemRendererBase()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerHeroListValueObject = data as PlayerHeroListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_heroEvolve.remove(listener_heroEvolve);
            _loc2_.signal_heroPromote.remove(listener_heroPromote);
         }
         .super.data = param1;
         var _loc3_:PlayerHeroListValueObject = param1 as PlayerHeroListValueObject;
         if(_loc3_)
         {
            _loc3_.signal_heroEvolve.add(listener_heroEvolve);
            _loc3_.signal_heroPromote.add(listener_heroPromote);
         }
      }
      
      override protected function commitData() : void
      {
         var _loc1_:PlayerHeroListValueObject = data as PlayerHeroListValueObject;
         if(_loc1_)
         {
            if(portrait.data == _loc1_)
            {
               portrait.data = null;
            }
            portrait.data = _loc1_;
         }
         super.commitData();
      }
      
      protected function createClip() : void
      {
         assetClip = AssetStorage.rsx.popup_theme.create_dialog_hero_list_item();
         addChild(assetClip.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         createClip();
         assetClip.bg_button.signal_click.add(listener_buttonClick);
         portrait = new HeroPortrait();
         assetClip.marker_hero_portrait_inst0.container.addChild(portrait);
      }
      
      protected function listener_buttonClick() : void
      {
      }
      
      protected function listener_heroEvolve() : void
      {
         var _loc1_:PlayerHeroListValueObject = data as PlayerHeroListValueObject;
         portrait.updateStars();
      }
      
      protected function listener_heroPromote() : void
      {
         var _loc1_:PlayerHeroListValueObject = data as PlayerHeroListValueObject;
         portrait.updateColor();
      }
   }
}
