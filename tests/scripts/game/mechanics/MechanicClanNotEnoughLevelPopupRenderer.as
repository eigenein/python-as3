package game.mechanics
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipLabel;
   
   public class MechanicClanNotEnoughLevelPopupRenderer extends MechanicNotEnoughLevelPopupRenderer
   {
       
      
      public var tf_1:ClipLabel;
      
      public var tf_2:ClipLabel;
      
      public var tf_3:ClipLabel;
      
      public function MechanicClanNotEnoughLevelPopupRenderer()
      {
         tf_1 = new ClipLabel();
         tf_2 = new ClipLabel();
         tf_3 = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_1.text = Translate.translate("UI_DIALOG_RUNES_ITEMS");
         tf_2.text = Translate.translate("UI_COMMON_HERO_POWER");
         tf_3.text = Translate.translate("UI_COMMON_HERO_POWER");
      }
   }
}
