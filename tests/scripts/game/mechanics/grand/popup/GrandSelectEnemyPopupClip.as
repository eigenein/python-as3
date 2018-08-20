package game.mechanics.grand.popup
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.ArenaEnemyPanelClip;
   
   public class GrandSelectEnemyPopupClip extends PopupClipBase
   {
       
      
      public var button_refresh:ClipButtonLabeled;
      
      public var enemy:Vector.<ArenaEnemyPanelClip>;
      
      public var layout:ClipLayout;
      
      public function GrandSelectEnemyPopupClip()
      {
         layout = ClipLayout.horizontalCentered(6);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.setNode(param1);
         if(enemy)
         {
            _loc2_ = enemy.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               layout.addChild(enemy[_loc3_].graphics);
               _loc3_++;
            }
         }
      }
   }
}
