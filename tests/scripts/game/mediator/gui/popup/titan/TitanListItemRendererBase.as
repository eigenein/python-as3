package game.mediator.gui.popup.titan
{
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.popup.hero.HeroListItemClipBase;
   
   public class TitanListItemRendererBase extends ListItemRenderer
   {
       
      
      protected var portrait:HeroPortrait;
      
      protected var assetClip:HeroListItemClipBase;
      
      public function TitanListItemRendererBase()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerTitanListValueObject = data as PlayerTitanListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_titanEvolve.remove(listener_heroEvolve);
            _loc2_.signal_titanPromote.remove(listener_titanPromote);
         }
         .super.data = param1;
         var _loc3_:PlayerTitanListValueObject = param1 as PlayerTitanListValueObject;
         if(_loc3_)
         {
            _loc3_.signal_titanEvolve.add(listener_heroEvolve);
            _loc3_.signal_titanPromote.add(listener_titanPromote);
         }
      }
      
      override protected function commitData() : void
      {
         var _loc1_:PlayerTitanListValueObject = data as PlayerTitanListValueObject;
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
         assetClip = AssetStorage.rsx.popup_theme.create_dialog_titan_list_item();
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
         var _loc1_:PlayerTitanListValueObject = data as PlayerTitanListValueObject;
         portrait.updateStars();
      }
      
      protected function listener_titanPromote() : void
      {
         var _loc1_:PlayerTitanListValueObject = data as PlayerTitanListValueObject;
         portrait.updateColor();
      }
   }
}
