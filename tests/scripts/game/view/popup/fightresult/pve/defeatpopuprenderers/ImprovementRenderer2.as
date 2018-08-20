package game.view.popup.fightresult.pve.defeatpopuprenderers
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipLabel;
   
   public class ImprovementRenderer2 extends ImprovementRenderer
   {
       
      
      public var rank_tf:ClipLabel;
      
      public var wear_tf:ClipLabel;
      
      public function ImprovementRenderer2()
      {
         rank_tf = new ClipLabel();
         wear_tf = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         label_desc.text = Translate.translate("UI_DIALOG_MISSION_DEFEAT_EQUIPMENT_DESC");
         rank_tf.text = Translate.translate("UI_DIALOG_HERO_BUTTON_PROMOTE");
         wear_tf.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_INSERT");
      }
   }
}
