package com.example.login_registro

import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.google.android.material.textfield.TextInputEditText
import org.json.JSONException
import org.json.JSONObject

class Login : AppCompatActivity() {

    private lateinit var textInputEditTextCorreo: TextInputEditText
    private lateinit var textInputEditTextPassword: TextInputEditText
    private lateinit var botonLogin: Button
    private lateinit var textError: TextView
    private lateinit var sharedPreferences: SharedPreferences

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        textInputEditTextCorreo = findViewById(R.id.correo)
        textInputEditTextPassword = findViewById(R.id.password)
        textError = findViewById(R.id.error_login)
        botonLogin = findViewById(R.id.login)

        sharedPreferences = getSharedPreferences("MyAppName", MODE_PRIVATE)

        if (sharedPreferences.getString("logged", "false") == "true") {
            startUserActivity()
        }

        botonLogin.setOnClickListener {
            login()
        }
    }

    fun onClickLogin(view: View) {
        login()
    }

    private fun login() {
        val correo = textInputEditTextCorreo.text.toString()
        val password = textInputEditTextPassword.text.toString()
        textError.visibility = View.GONE

        val queue: RequestQueue = Volley.newRequestQueue(applicationContext)
        val url = "http://192.168.144.167/login_register/login.php"

        val stringRequest = object : StringRequest(Request.Method.POST, url,
            Response.Listener<String> { response ->
                try {
                    val jsonObject = JSONObject(response)
                    val status = jsonObject.getString("status")
                    val message = jsonObject.getString("message")
                    if (status == "success") {
                        val nombre = jsonObject.getString("nombre")
                        val apiKey = jsonObject.getString("apiKey")
                        saveToSharedPreferences(nombre, correo, apiKey)
                        startUserActivity()
                    } else {
                        showError(message)
                    }
                } catch (e: JSONException) {
                    showError("Error de respuesta del servidor")
                }
            },
            Response.ErrorListener { error ->
                showError("Error de red: ${error.message}")
            }
        ) {
            override fun getParams(): Map<String, String> {
                val params: MutableMap<String, String> = HashMap()
                params["Correo"] = correo
                params["Password"] = password
                return params
            }
        }
        queue.add(stringRequest)
    }

    private fun saveToSharedPreferences(nombre: String, correo: String, apiKey: String) {
        val editor: SharedPreferences.Editor = sharedPreferences.edit()
        editor.putString("logged", "true")
        editor.putString("Nombre", nombre)
        editor.putString("Correo", correo)
        editor.putString("apiKey", apiKey)
        editor.apply()
    }

    private fun startUserActivity() {
        val intent = Intent(applicationContext, User::class.java)
        startActivity(intent)
        finish()
    }

    private fun showError(message: String) {
        textError.text = message
        textError.visibility = View.VISIBLE
    }

    fun irCrear(view: View) {
        val intent = Intent(this, Register::class.java)
        startActivity(intent)
    }
}
