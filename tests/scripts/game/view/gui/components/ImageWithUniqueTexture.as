package game.view.gui.components
{
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class ImageWithUniqueTexture extends Image
   {
       
      
      public function ImageWithUniqueTexture(param1:Texture)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         texture.dispose();
      }
   }
}
