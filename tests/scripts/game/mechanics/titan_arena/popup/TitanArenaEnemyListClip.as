package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.ClipAnimatedContainer;
   
   public class TitanArenaEnemyListClip extends ClipAnimatedContainer
   {
       
      
      public var enemy:Vector.<TitanArenaEnemyClip>;
      
      public function TitanArenaEnemyListClip()
      {
         enemy = new Vector.<TitanArenaEnemyClip>();
         super();
      }
   }
}
