package game.view.popup.fightresult.pve.defeatpopuprenderers
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ImprovementRenderer7 extends ImprovementRenderer
   {
       
      
      public var action1_tf:ClipLabel;
      
      public var action2_tf:ClipLabel;
      
      public var desc1_tf:ClipLabel;
      
      public var desc2_tf:ClipLabel;
      
      public function ImprovementRenderer7()
      {
         action1_tf = new SpecialClipLabel();
         action2_tf = new ClipLabel();
         desc1_tf = new ClipLabel();
         desc2_tf = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         label_desc.text = Translate.translate("UI_DIALOG_MISSION_DEFEAT_TITAN_EVOLUTION_DESC");
         action1_tf.text = Translate.translate("UI_DIALOG_HERO_BUTTON_EVOLVE");
         action2_tf.text = Translate.translate("UI_DIALOG_TITAN_FIND");
         desc1_tf.text = Translate.translate("UI_DIALOG_TITAN_FRAGMENTS_DESC");
         desc2_tf.text = Translate.translate("UI_DIALOG_TITAN_SUMMON_CIRCLE");
      }
   }
}
