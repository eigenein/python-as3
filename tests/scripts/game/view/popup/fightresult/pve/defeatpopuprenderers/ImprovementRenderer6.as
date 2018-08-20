package game.view.popup.fightresult.pve.defeatpopuprenderers
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ImprovementRenderer6 extends ImprovementRenderer
   {
       
      
      public var level_tf:SpecialClipLabel;
      
      public var desc_tf:ClipLabel;
      
      public var amount_tf:ClipLabel;
      
      public var action_tf:ClipLabel;
      
      public function ImprovementRenderer6()
      {
         level_tf = new SpecialClipLabel();
         desc_tf = new ClipLabel();
         amount_tf = new ClipLabel();
         action_tf = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         label_desc.text = Translate.translate("UI_DIALOG_MISSION_DEFEAT_TITAN_LEVEL_UP_DESC");
         level_tf.text = Translate.translate("UI_DIALOG_TITAN_LEVEL") + " " + ColorUtils.hexToRGBFormat(16645626) + 1;
         desc_tf.text = Translate.translate("UI_DIALOG_TITAN_LEVEL_UP_1");
         action_tf.text = Translate.translate("UI_DIALOG_TITAN_LEVEL_UP");
         amount_tf.text = "10";
      }
   }
}
