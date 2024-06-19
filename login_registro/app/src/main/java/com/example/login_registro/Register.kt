package com.example.login_registro

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.google.android.material.textfield.TextInputEditText

class Register : AppCompatActivity() {

    private lateinit var textInputEditTextNombre: TextInputEditText
    private lateinit var textInputEditTextCorreo: TextInputEditText
    private lateinit var textInputEditTextPassword: TextInputEditText
    private lateinit var textError: TextView
    private lateinit var botonCrear: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_register)

        textInputEditTextNombre = findViewById(R.id.nombre)
        textInputEditTextCorreo = findViewById(R.id.correo)
        textInputEditTextPassword = findViewById(R.id.password)
        textError = findViewById(R.id.text_error)
        botonCrear = findViewById(R.id.boton_crear)

        botonCrear.setOnClickListener {
            val nombre = textInputEditTextNombre.text.toString()
            val correo = textInputEditTextCorreo.text.toString()
            val password = textInputEditTextPassword.text.toString()
            textError.visibility = View.GONE

            val queue: RequestQueue = Volley.newRequestQueue(applicationContext)
            val url = "http://192.168.144.167/login_register/register.php"

            val stringRequest = object : StringRequest(Request.Method.POST, url,
                Response.Listener<String> { response ->
                    if (response.equals("success", ignoreCase = true)) {
                        Toast.makeText(applicationContext, "Registro exitoso", Toast.LENGTH_SHORT).show()
                        val intent = Intent(applicationContext, Login::class.java)
                        startActivity(intent)
                        finish()
                    } else {
                        textError.text = response
                        textError.visibility = View.VISIBLE
                    }
                }, Response.ErrorListener { error ->
                    textError.text = getString(R.string.network_error_message, error.message)
                    textError.visibility = View.VISIBLE
                }) {
                override fun getParams(): Map<String, String> {
                    val params: MutableMap<String, String> = HashMap()
                    params["Nombre"] = nombre
                    params["Correo"] = correo
                    params["Password"] = password
                    return params
                }
            }
            queue.add(stringRequest)
        }
    }
    fun irInicio(view: View) {
        val intent = Intent(this, MainActivity::class.java)
        startActivity(intent)
    }
}
