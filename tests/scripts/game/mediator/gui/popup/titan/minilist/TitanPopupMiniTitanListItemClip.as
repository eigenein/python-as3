package game.mediator.gui.popup.titan.minilist
{
   import engine.core.clipgui.ClipSprite;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.titan.PlayerTitanListValueObject;
   import game.view.gui.components.hero.MiniHeroPortraitClip;
   
   public class TitanPopupMiniTitanListItemClip extends MiniHeroPortraitClip
   {
       
      
      public var icon_red:ClipSprite;
      
      public var glow_select:ClipSprite;
      
      public function TitanPopupMiniTitanListItemClip()
      {
         icon_red = new ClipSprite();
         glow_select = new ClipSprite();
         super();
      }
      
      override public function set data(param1:UnitEntryValueObject) : void
      {
         var _loc2_:PlayerTitanListValueObject = _data as PlayerTitanListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_updateActionAvailable.remove(handler_redDotStateChange);
            _loc2_.signal_titanPromote.remove(handler_starsUpdate);
            _loc2_.signal_titanEvolve.remove(handler_colorUpdate);
            _loc2_.signal_artifactLevelUp.remove(handler_artifactLevelUp);
            _loc2_.signal_artifactEvolve.remove(handler_artifactEvolve);
         }
         if(!param1)
         {
            return;
         }
         .super.data = param1;
         _loc2_ = param1 as PlayerTitanListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_updateActionAvailable.add(handler_redDotStateChange);
            _loc2_.signal_titanPromote.add(handler_starsUpdate);
            _loc2_.signal_titanEvolve.add(handler_colorUpdate);
            _loc2_.signal_artifactLevelUp.add(handler_artifactLevelUp);
            _loc2_.signal_artifactEvolve.add(handler_artifactEvolve);
         }
         handler_redDotStateChange();
      }
      
      private function handler_starsUpdate() : void
      {
         .super.data = _data;
      }
      
      private function handler_colorUpdate() : void
      {
         .super.data = _data;
      }
      
      private function handler_artifactLevelUp() : void
      {
      }
      
      private function handler_artifactEvolve() : void
      {
      }
      
      private function handler_redDotStateChange() : void
      {
         var _loc1_:PlayerTitanListValueObject = _data as PlayerTitanListValueObject;
         icon_red.graphics.visible = !!_loc1_?_loc1_.redDotState:false;
      }
   }
}
