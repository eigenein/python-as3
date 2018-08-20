package game.view.gui.clanscreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class ClanScreenTitanArenaButtonSpiritTotemClip extends GuiClipNestedContainer
   {
       
      
      public var level:Vector.<GuiAnimation>;
      
      public function ClanScreenTitanArenaButtonSpiritTotemClip()
      {
         level = new Vector.<GuiAnimation>();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         setStar(-1);
      }
      
      public function setStar(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = level.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_loc3_ == param1)
            {
               level[_loc3_].graphics.visible = true;
               level[_loc3_].play();
            }
            else
            {
               level[_loc3_].graphics.visible = false;
               level[_loc3_].stop();
            }
            _loc3_++;
         }
      }
   }
}
