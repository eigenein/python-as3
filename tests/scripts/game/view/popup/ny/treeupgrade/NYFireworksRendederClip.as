package game.view.popup.ny.treeupgrade
{
   import com.progrestar.common.lang.Translate;
   
   public class NYFireworksRendederClip extends NYTreeDecorateRendederClip
   {
       
      
      public function NYFireworksRendederClip()
      {
         super();
      }
      
      override public function get titleLabel() : String
      {
         return Translate.translateArgs("UI_FIREWORKS_LAUNCH_POPUP_TF_HEADER");
      }
      
      override public function get buttonLabel() : String
      {
         return Translate.translate("UI_FIREWORKS_LAUNCH_POPUP_TF_LAUNCH");
      }
   }
}
