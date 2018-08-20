package game.view.popup.artifactstore
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ArtifactStorePopupClip extends PopupClipBase
   {
       
      
      public var tf_desc:ClipLabel;
      
      public var btn_action:ClipButtonLabeled;
      
      public var item:Vector.<ArtifactStoreItemRenderer>;
      
      public var minilist_layout_container:ClipLayout;
      
      public var miniList_rightArrow:ClipButton;
      
      public var miniList_leftArrow:ClipButton;
      
      public function ArtifactStorePopupClip()
      {
         tf_desc = new ClipLabel();
         btn_action = new ClipButtonLabeled();
         item = new Vector.<ArtifactStoreItemRenderer>();
         minilist_layout_container = ClipLayout.horizontalMiddleCentered(0);
         super();
      }
   }
}
