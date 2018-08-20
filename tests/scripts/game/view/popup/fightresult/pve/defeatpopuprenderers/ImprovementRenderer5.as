package game.view.popup.fightresult.pve.defeatpopuprenderers
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ImprovementRenderer5 extends ImprovementRenderer
   {
       
      
      public var desc_tf:SpecialClipLabel;
      
      public var title_tf:ClipLabel;
      
      public var upgrade_tf:ClipLabel;
      
      public function ImprovementRenderer5()
      {
         desc_tf = new SpecialClipLabel();
         title_tf = new ClipLabel();
         upgrade_tf = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         label_desc.text = Translate.translate("UI_DIALOG_MISSION_DEFEAT_SKINS_DESC");
         desc_tf.text = Translate.translate("LIB_BATTLESTATDATA_MAGICPOWER") + ColorUtils.hexToRGBFormat(15007564) + "\n+" + 600 + "\n" + ColorUtils.hexToRGBFormat(16645626) + Translate.translate("UI_DIALOG_HERO_LEVEL_LABEL") + " 1/60";
         title_tf.text = Translate.translate("LIB_SKIN_NAME_ANGEL");
         upgrade_tf.text = Translate.translate("UI_DIALOG_HERO_GUISE_UPGRADE");
      }
   }
}
