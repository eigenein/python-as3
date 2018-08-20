package game.view.popup.tower
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class TowerBattleFloorPopupClip extends PopupClipBase
   {
       
      
      public var tf_floor:ClipLabel;
      
      public var tf_floor_label:ClipLabel;
      
      public var button_skip:ClipButtonLabeled;
      
      public var tf_skip_label:ClipLabel;
      
      public var enemy_1:TowerBattleEnemyPanelClip;
      
      public function TowerBattleFloorPopupClip()
      {
         super();
      }
   }
}
