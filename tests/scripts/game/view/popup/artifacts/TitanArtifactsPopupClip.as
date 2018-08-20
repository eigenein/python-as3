package game.view.popup.artifacts
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TitanArtifactsPopupClip extends PopupClipBase
   {
       
      
      public var artifacts_list_container:GuiClipLayoutContainer;
      
      public var info:TitanArtifactsInfoClip;
      
      public var minilist_layout_container:ClipLayout;
      
      public var miniList_rightArrow:ClipButton;
      
      public var miniList_leftArrow:ClipButton;
      
      public var level_up_clip:TitanArtifactLevelUpClip;
      
      public var evolve_clip:TitanArtifactEvolveClip;
      
      public function TitanArtifactsPopupClip()
      {
         artifacts_list_container = new GuiClipLayoutContainer();
         info = new TitanArtifactsInfoClip();
         minilist_layout_container = ClipLayout.horizontalCentered(0);
         level_up_clip = new TitanArtifactLevelUpClip();
         evolve_clip = new TitanArtifactEvolveClip();
         super();
      }
   }
}
