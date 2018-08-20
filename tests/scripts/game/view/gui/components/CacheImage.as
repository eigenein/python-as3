package game.view.gui.components
{
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   
   public class CacheImage
   {
       
      
      private var _path:String;
      
      private var _container:DisplayObjectContainer;
      
      private var _onComplete:Function = null;
      
      private var _image:Image;
      
      private var _preloader:Image;
      
      private var _relative:Boolean;
      
      public function CacheImage(param1:String, param2:DisplayObjectContainer, param3:Function, param4:Boolean)
      {
         super();
         _path = param1;
         _container = param2;
         _onComplete = param3;
         _relative = param4;
      }
      
      public function get path() : String
      {
         return _path;
      }
      
      public function set path(param1:String) : void
      {
         _path = param1;
      }
      
      public function get container() : DisplayObjectContainer
      {
         return _container;
      }
      
      public function set container(param1:DisplayObjectContainer) : void
      {
         _container = param1;
      }
      
      public function get onComplete() : Function
      {
         return _onComplete;
      }
      
      public function set onComplete(param1:Function) : void
      {
         _onComplete = param1;
      }
      
      public function get image() : Image
      {
         return _image;
      }
      
      public function set image(param1:Image) : void
      {
         if(_image == param1)
         {
            return;
         }
         _image = param1;
      }
      
      public function get preloader() : Image
      {
         return _preloader;
      }
      
      public function set preloader(param1:Image) : void
      {
         if(_preloader == param1)
         {
            return;
         }
         _preloader = param1;
      }
      
      public function get relative() : Boolean
      {
         return _relative;
      }
      
      public function set relative(param1:Boolean) : void
      {
         _relative = param1;
      }
   }
}
