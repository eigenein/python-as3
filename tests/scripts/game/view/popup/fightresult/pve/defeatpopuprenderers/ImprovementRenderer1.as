package game.view.popup.fightresult.pve.defeatpopuprenderers
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ImprovementRenderer1 extends ImprovementRenderer
   {
       
      
      public var level_tf:SpecialClipLabel;
      
      public var evo_tf:ClipLabel;
      
      public function ImprovementRenderer1()
      {
         level_tf = new SpecialClipLabel();
         evo_tf = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         label_desc.text = Translate.translate("UI_DIALOG_MISSION_DEFEAT_EVOLUTION_DESC");
         level_tf.text = ColorUtils.hexToRGBFormat(16573879) + Translate.translate("UI_DIALOG_HERO_LEVEL_LABEL") + " " + ColorUtils.hexToRGBFormat(16645626) + 18;
         evo_tf.text = Translate.translate("UI_DIALOG_HERO_BUTTON_EVOLVE");
      }
   }
}
