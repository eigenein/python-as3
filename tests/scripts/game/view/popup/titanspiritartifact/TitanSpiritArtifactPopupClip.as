package game.view.popup.titanspiritartifact
{
   import game.view.PopupClipBase;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TitanSpiritArtifactPopupClip extends PopupClipBase
   {
       
      
      public var info:TitanSpiritArtifactInfoClip;
      
      public var level_up_clip:TitanSpiritArtifactLevelUpClip;
      
      public var evolve_clip:TitanSpiritArtifactEvolveClip;
      
      public var minilist_layout_container:GuiClipLayoutContainer;
      
      public function TitanSpiritArtifactPopupClip()
      {
         info = new TitanSpiritArtifactInfoClip();
         level_up_clip = new TitanSpiritArtifactLevelUpClip();
         evolve_clip = new TitanSpiritArtifactEvolveClip();
         minilist_layout_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
