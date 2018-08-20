package game.mechanics.grand.popup
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class GrandBattleResultSinglePopupClip extends PopupClipBase
   {
       
      
      public var bounds_layout_container:GuiClipLayoutContainer;
      
      public var tf_label_score:ClipLabel;
      
      public var tf_score:ClipLabel;
      
      public var button_stats:ClipButtonLabeled;
      
      public var button_continue:ClipButtonLabeled;
      
      public var panel_attacker:GrandBattleResultPlayerPanelClip;
      
      public var panel_defender:GrandBattleResultPlayerPanelClip;
      
      public function GrandBattleResultSinglePopupClip()
      {
         super();
      }
   }
}
