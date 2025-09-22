using Nascimento.Shader.Model;
using Nascimento.Shader.View;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

namespace Nascimento.Shader.Model
{
    public class ShaderInfo
    {
        public string Version;
        public string Shader;
    }

}


namespace Nascimento.Shader.View
{
    public class RuntimeShaderView
    {
        private readonly RawImage _image;

        public RuntimeShaderView(RawImage rawImage)
        {
            _image = rawImage;
        }

        public void SetupShader(ShaderInfo info)
        {
            //todo Copies the current _image's material, but updates the shader of the new material from info.Shader
        }
    }
}

namespace Nascimento.Shader.Controller
{

    public class RuntimeShaderController : MonoBehaviour
    {
        [Header("Setup")]
        [SerializeField]
        private TextAsset _gsl;
        [SerializeField]
        private RawImage _rawImage;
        private RuntimeShaderView _view;

        void Start()
        {
            var info = new ShaderInfo()
            {
                Version = "1.0",
                Shader = _gsl.text,
            };

            _view = new RuntimeShaderView(_rawImage);
            _view.SetupShader(info);
        }
    }
}