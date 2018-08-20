package game.view.popup.shop.special
{
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.gui.components.hero.MiniHeroPortraitClip;
   
   public class SpecialShopMiniHeroListItemClip extends MiniHeroPortraitClip
   {
       
      
      public var glow_select:GuiClipScale9Image;
      
      public function SpecialShopMiniHeroListItemClip()
      {
         glow_select = new GuiClipScale9Image(new Rectangle(21,19,1,1));
         super();
      }
      
      override public function set data(param1:UnitEntryValueObject) : void
      {
         removeListeners(_data as PlayerHeroListValueObject);
         if(!param1)
         {
            return;
         }
         .super.data = param1;
         addListeners(param1 as PlayerHeroListValueObject);
      }
      
      protected function addListeners(param1:PlayerHeroListValueObject) : void
      {
         if(param1)
         {
            param1.signal_heroPromote.add(handler_starsUpdate);
            param1.signal_heroEvolve.add(handler_colorUpdate);
         }
      }
      
      protected function removeListeners(param1:PlayerHeroListValueObject) : void
      {
         if(param1)
         {
            param1.signal_heroPromote.remove(handler_starsUpdate);
            param1.signal_heroEvolve.remove(handler_colorUpdate);
         }
      }
      
      private function handler_starsUpdate() : void
      {
         .super.data = _data;
      }
      
      private function handler_colorUpdate() : void
      {
         .super.data = _data;
      }
   }
}
