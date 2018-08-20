package game.view.popup.artifacts
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class HeroArtifactsPopupClip extends PopupClipBase
   {
       
      
      public var artifacts_list_container:GuiClipLayoutContainer;
      
      public var info:HeroArtifactsInfoClip;
      
      public var minilist_layout_container:ClipLayout;
      
      public var miniList_rightArrow:ClipButton;
      
      public var miniList_leftArrow:ClipButton;
      
      public var level_up_clip:HeroArtifactLevelUpClip;
      
      public var evolve_clip:HeroArtifactEvolveClip;
      
      public function HeroArtifactsPopupClip()
      {
         artifacts_list_container = new GuiClipLayoutContainer();
         info = new HeroArtifactsInfoClip();
         minilist_layout_container = ClipLayout.horizontalCentered(0);
         level_up_clip = new HeroArtifactLevelUpClip();
         evolve_clip = new HeroArtifactEvolveClip();
         super();
      }
   }
}
